From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Sun, 8 Jan 2017 23:56:49 +0000
Subject: [PATCH 1/5] drivers: mmc: sunxi: fix A64 calibration routine
In-Reply-To: <20170105174725.kmr25iodjnjozqjm@lukather>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-2-git-send-email-andre.przywara@arm.com>
 <20170105174725.kmr25iodjnjozqjm@lukather>
Message-ID: <95b2e25c-da97-4136-3c49-ff8ecf011c14@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/17 17:47, Maxime Ripard wrote:

Hi,

> On Mon, Jan 02, 2017 at 11:03:42PM +0000, Andre Przywara wrote:
>> The calibration facility in the A64 MMC block seems to have been
>> misunderstood: the result value is not the value to program into the
>> delay bits, but is the number of delay cells that result in a full clock
>> cycle delay. So this value has to be scaled by the desired phase, which
>> we still have to know and program.
>> Change the calibration routine to take a phase parameter and scale the
>> calibration value accordingly.
>> Also introduce sun50i-a64 delay parameters to store the required phase.
>> Looking at the BSP kernel the sample delay for anything below HS200 is
>> 0, so we go with that value.
>> Once the driver supports HS200 and faster modes, we can enter confirmed
>> working values in there.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Exactly how that works hasn't been confirmed, and the only thing that
> this patch actually do is... nothing, since the delay is always 0. If
> and when we get HS400 to work and we know for a fact how the
> calibration works, then we'll be able to use it. Until then, we can
> just clear those bits.

Fair enough, though I am a bit puzzled as what to do here now:

Dropping this patch here entirely causes the wrong calibration settings
to degrade the BananaPi eMMC performance by up to 50% (20 MB/s vs.
40MB/s in hdparm, and 25% longer execution time for a "find / -type f |
xargs md5sum > /dev/null" run). So this is not an option.

1) Shall I simply revert Icenowy's original patch that introduced the
calibration function? That should leave the values at their reset value
of 0.  But do we want to make sure that these values are set to 0 by
explicitly zeroing the bits?
Also I guess your HS-400 support will need to write some values in
there, so we will need some code later again?

2) Changing the calibration function to don't do any calibration really
and just write 0 into the delay bits seems like an option, but looks a
bit weird. Also I guess your faster transfer modes support will need to
write _something_, though I don't know what those values are and where
they will come from.

So I am leaning towards 1) for now, unless you send your MMC patches and
we at least merge the patch dealing with the calibration part for the
next release.

Any recommendations? I would love to see the MMC support go into 4.11.

Cheers,
Andre.
