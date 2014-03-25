From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Tue, 25 Mar 2014 22:03:29 +0000
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140325213638.5aba54b6@skate>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com> <20140325213638.5aba54b6@skate>
Message-ID: <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas et al,

On Tue, Mar 25, 2014 at 8:36 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Jason, Neil,
>
> On Tue, 25 Mar 2014 14:22:49 -0600, Jason Gunthorpe wrote:
>
>> > mirabox ~ # lspci
>> > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
>> > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
>> > 02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)
>>
>> A starting guess is that something to do with the reset sequence is
>> not long enough. PCI requires a certain time in-reset before a device
>> is required to respond to configuration... Depending on what your
>> bootloader does Linux might be the first thing to enable the link. Add
>> a 1 second sleep to the mvebu driver before the bus scan and see if
>> that helps?
>>

<snip>

> We have recently identified a weird thing on Armada 38x, maybe previous
> revisions are affected as well. We haven't fully understood the problem
> yet, but the following patch allows PCIe devices to be detected in all
> situations on Armada 38x. It seems like setting the local device number
> requires "some time" to be taken into account.
>
> Neil, could you test the below patch:
>

<patch snipped>

I applied the patch as given with udelay(100) and it made no difference.

I then replaced it with mdelay(1000) out of interest, and it succeeded
in detecting the card at boot. It then proceeded exactly as described
by Willy in his later e-mail (it successfully registers an MSI-X
interrupt for one port, and then proceeds to implode).

Here's the console output for this boot:
https://gist.github.com/ngreatorex/9771902
Here's the "lspci -vvv" after the oops:
https://gist.github.com/ngreatorex/9771943

I then blacklisted igb to prevent modprobe loading the module, and it
boots fine, with the card detected in lspci. Here's the "lspci -vvv"
for that situation: https://gist.github.com/ngreatorex/9772195

With the module blacklisted, I then tried rescanning the bus, and
there were no changes - the Fresco controller didn't go haywire and
show up twice.

Do you want me to experiment with different delays and see where the
detection starts to fail?

>
> It will clearly not solve the MSI-X panic, but maybe the PCIe device
> detection problem at boot time. It would be nice if you could check
> this, and also see if the weird Fresco double instance disappears.
>
> Thanks!
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
