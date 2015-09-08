From: songjun.wu@atmel.com (Wu, Songjun)
Date: Tue, 8 Sep 2015 17:36:01 +0800
Subject: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
In-Reply-To: <20150907162350.GV5313@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
 <20150903113716.GU12027@sirena.org.uk> <55EC0AF5.8060403@atmel.com>
 <20150907162350.GV5313@sirena.org.uk>
Message-ID: <55EEAC01.3080409@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/8/2015 00:23, Mark Brown wrote:
> On Sun, Sep 06, 2015 at 05:44:21PM +0800, Wu, Songjun wrote:
>> On 9/3/2015 19:37, Mark Brown wrote:
>>> On Tue, Sep 01, 2015 at 01:41:40PM +0800, Songjun Wu wrote:
>
>>>> +static const char * const eqcfg_bass_text[] = {
>>>> +	"-12 dB", "-6 dB", "0 dB", "+6 dB", "+12 dB"
>>>> +};
>>>
>>>> +static const unsigned int eqcfg_bass_value[] = {
>>>> +	CLASSD_INTPMR_EQCFG_B_CUT_12,
>>>> +	CLASSD_INTPMR_EQCFG_B_CUT_6, CLASSD_INTPMR_EQCFG_FLAT,
>>>> +	CLASSD_INTPMR_EQCFG_B_BOOST_6, CLASSD_INTPMR_EQCFG_B_BOOST_12
>>>> +};
>
>>> This should be a Volume control with TLV information, as should the
>>> following few controls.
>
>> The Volume control with TLV information is not suitable for this case.
>> Bass, Medium, and treble are mutually exclusive.
>> So I think the SOC_ENUM control is suitable for this case.
>> The register layout is not very good,
>> The register is defined as below.
>> ?  EQCFG: Equalization Selection
>> Value Name       Description
>> 0     FLAT       Flat Response
>> 1     BBOOST12   Bass boost +12 dB
>> 2     BBOOST6    Bass boost +6 dB
>> 3     BCUT12     Bass cut -12 dB
>> 4     BCUT6      Bass cut -6 dB
>> 5     MBOOST3    Medium boost +3 dB
>> 6     MBOOST8    Medium boost +8 dB
>> 7     MCUT3      Medium cut -3 dB
>> 8     MCUT8      Medium cut -8 dB
>> 9     TBOOST12   Treble boost +12 dB
>> 10    TBOOST6    Treble boost +6 dB
>> 11    TCUT12     Treble cut -12 dB
>> 12    TCUT6      Treble cut -6 dB
>
> OK, so that's not actually what the code was doing - it had separate
> enums for bass, mid and treble.  If you make this a single enum with all
> the above options in it that seems like the best way of handling things.
>
A single enum seems not very friendly to user, there are tree EQs, bass, 
medium and treble.
So I create tree enum controls to control three EQs.
The 'get' function is replaced by 'classd_get_eq_enum', if user operates 
one of the tree EQ controls, the other two EQs will show 0 dB.

>>>> +static const struct snd_kcontrol_new atmel_classd_snd_controls[] = {
>>>> +SOC_SINGLE_TLV("Left Volume", CLASSD_INTPMR,
>>>> +		CLASSD_INTPMR_ATTL_SHIFT, 78, 1, classd_digital_tlv),
>>>> +
>>>> +SOC_SINGLE_TLV("Right Volume", CLASSD_INTPMR,
>>>> +		CLASSD_INTPMR_ATTR_SHIFT, 78, 1, classd_digital_tlv),
>>>
>>> This should be a single stereo control rather than separate left and
>>> right controls.
>
>> Since the classD IP defines two register fields to control left volume and
>> right volume respectively, I think it's better to provide two controls to
>> user.
>
> No, this is really common, we combine them in Linux to present a
> consistent interface to userspace.
>
I think carefully, your suggestion is reasonable.
The code will be modified, combine the left and right to a single stereo 
control.
Thank you.

>>>> +	dev_info(dev,
>>>> +		"Atmel Class D Amplifier (CLASSD) device at 0x%p (irq %d)\n",
>>>> +		io_base, dd->irq);
>
>>> This is a bit noisy and not really based on interaction with the
>>> hardware...  dev_dbg() seems better.
>
>> This information will occur only once when linux kernel starts.
>> It shows the classD is loaded to linux kernel.
>> I think it's better to provide more information to user.
>
> This stuff all adds up and since it'll go out on the console by default
> it both makes things more noisy and slows down boot - printing on the
> serial port isn't free.  If we want to have this sort of information we
> printed we should really do it in the driver core so it appears
> consistently for all devices rather than having individual code in each
> driver.
>
Accept, the code will be modified to dev_dbg().
