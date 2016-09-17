From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Sat, 17 Sep 2016 12:02:16 +0200
Subject: [PATCH 2/5] mmc: bcm2835-sdhost: Add new driver for the internal
 SD controller.
In-Reply-To: <877falaq1q.fsf@eliezer.anholt.net>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
 <1466595738-2229-3-git-send-email-kraxel@redhat.com>
 <CAPDyKFryfGpA+8tZhtkzUVMFhomOevFz8k9R1b2O0oUn8giT1w@mail.gmail.com>
 <1473347315.6698.53.camel@redhat.com> <877falaq1q.fsf@eliezer.anholt.net>
Message-ID: <CAPDyKFoASzRdA0Vy6P4hQ2OB845+YFosTXMAekEvpAOfco7m8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 September 2016 at 20:25, Eric Anholt <eric@anholt.net> wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
>
>> On Mi, 2016-08-31 at 14:58 +0200, Ulf Hansson wrote:
>>> On 22 June 2016 at 13:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> > From: Eric Anholt <eric@anholt.net>
>>> >
>>> > The 2835 has two SD controllers: The Arasan SDHCI controller that we
>>> > currently use, and a custom SD controller.  The custom one runs faster
>>> >
>>> > The code was originally written by Phil Elwell in the downstream
>>> > Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
>>> > out of the original 2055) for inclusion.
>>> >
>>> > Signed-off-by: Eric Anholt <eric@anholt.net>
>>>
>>> Apologize for the delay!
>>
>> No problem, I was on summer vacation anyway ...
>>
>>> Could you start by providing some more information about the driver
>>> and the controller in change in the change log please.
>>
>> Eric?  I don't know much more than what the commit message above says.
>>
>> Beside the speedup mentioned above driving the sdcard with the custom sd
>> controller allows to use the sdhci (handled by sdhci-iproc) to be used
>> for the wifi on the rpi3.
>
> Maybe just add that we need both controllers in order to do both wifi
> and SD card?  I don't know exactly what Ulf wants to see here.

Some toplevel description of the controller. Like what speed modes it
supports, can it do SD/SDIO/eMMC and so forth.

>
>>> > +static void bcm2835_sdhost_set_power(struct bcm2835_host *host, bool on)
>>> > +{
>>> > +       bcm2835_sdhost_write(host, on ? 1 : 0, SDVDD);
>>>
>>> What exactly does this power on/off?
>>
>> Dunno.  Eric?
>
> Note: I don't know much about SD, so I'm just trying to play oracle for
> you all here.
>
> VDD bit 0 (POWER_ON) starts the power-on setup cycle by the sdhost once
> power is already supplied to the card by some other means.  In the
> SDHOST docs they assume you're going to use GPIO to control SD card
> power, but for Raspberry Pi they just have the SD Card's VDD always on.
> It's unclear to me what's controlling power to the Pi3 wifi/BT's SD
> client, but I don't have specs to it.

Very useful information, could we fold something like this in as
comment in the code!?

>
> Note that after you've set POWER_ON to 0, you can also set bit 1
> (CLOCK_OFF) to 1 to turn off the clock to the power-on FSM.

Ditto.

>
>>> > +       /* Need to send CMD12 if -
>>> > +        * a) open-ended multiblock transfer (no CMD23)
>>> > +        * b) error in multiblock transfer
>>> > +        */
>>> > +       if (host->mrq->stop && (data->error || !host->use_sbc)) {
>>> > +               if (bcm2835_sdhost_send_command(host, host->mrq->stop)) {
>>> > +                       /* No busy, so poll for completion */
>>> > +                       if (!host->use_busy)
>>>
>>> This looks a bit weird. Can you explain why this is needed?
>>
>> Eric, any clue?  Some hardware bug workaround?
>> Have a pointer to hardware specs?
>
> Would no-CMD23 transfers mean that data->blocks was 0 to mean
> indefinite?  That's the only mention of CMD12 in the spec -- when you've
> set HBLC to 0, you need to CMD12 or CMD52 when you're done with the
> transfer.

Perhaps you are right, although the comments above is weird.

The driver should check if it's a request with R1B response, as to
find out when to care about busy detection. I have feeling that there
might be some odd things going on in this driver related to this. I
could be wrong through.

I advised Gerd to have a look how MMC_CAP_WAIT_WHILE_BUSY is working,
so perhaps Gerd can figure this out when he understands that part
better!?

>
>>> > +static void bcm2835_sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> > +{
>>>
>>> I don't find any place where you control power to the card here. Don't
>>> you need to do that?
>>
>> Eric?
>
> It looks like the card is always powered.  Do you mean something else by
> power (like bringing up the FSM)?  Is there something else needed in
> set_ios()?

As you told me above, you are using an external regulator to power the
card (VDD). And it seems like in this particular case this is always
powered on.

Still, my recommendation is to model this as a regulator, as it would
prevent you from hard-coding the so called mmc->ocr_mask_avail.
Instead that mask can be fetched by checking the supported voltage
levels from the regulators.

Please have a look at mmc_regulator_get_supply() and
mmc_regulator_set_ocr(), those helpers are really convenient to use.
You should be using the "vmmc" regulator for this purpose.

Kind regards
Uffe
