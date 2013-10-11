From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Oct 2013 16:55:58 +0200
Subject: [PATCH v4 0/5] dma: mxs-dma bugfixes and cleanup
In-Reply-To: <CAOMZO5AG_efwTbtUjG8TPEY=_kyjrcZkEQV6XfZ6CLZ3_msWig@mail.gmail.com>
References: <1381493539-31756-1-git-send-email-mpa@pengutronix.de>
 <CAOMZO5AG_efwTbtUjG8TPEY=_kyjrcZkEQV6XfZ6CLZ3_msWig@mail.gmail.com>
Message-ID: <20131011145558.GJ19005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Oct 11, 2013 at 11:01:29AM -0300, Fabio Estevam wrote:
> Hi Markus,
> 
> [Also including alsa-devel and some other folks involved with mxs audio]
> 
> On Fri, Oct 11, 2013 at 9:12 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> > Hi,
> >
> > v4 adds another patch to increase sound stability. Patch 3 ("dma: mxs-dma: Fix
> > channel reset hardware bug") decreases the number of channel stalls, but after
> > hours of repeated playback the bug still appears. The new patch ("dma: mxs: Use
> > semaphores for cyclic DMA") replaces reset channel usage with hardware
> > semaphore counter mechanism.
> 
> How is the bug you are trying to solve manifest and how to reproduce it?

My testcase is the following:

/bin/sh -c "while true; do ifconfig $net down; ifconfig $net up; done" &
while $(timeout 10 aplay --period-size=160 --buffer-size=320 $audio_file); do ; done

$audio_file is a 1 second testfile: Signed 16 bit Little Endian, Rate 16000 Hz, Mono

The network interface up/down loop creates enough load that aplay is not
able to deliver enough audio data into the DMA buffer resulting in many
playback interruptions. The interruptions are triggered by the pcm_lib
as soon as there is not enough data in the DMA buffer.

To stop the playback a DMA channel reset is executed. Sometimes this
can lead to a channel stall. There is no audio playback possible until
the next reboot or DMA engine reset. I fixed it by replacing channel
reset with hardware semaphore counter.

The second issue was a sound quality problem. With one of those
interruptions in playback, it was possible that the DMA buffer position
pointer gets wrong due to missed interrupt calls. The result is a bad
sound quality because the DMA engine is reading the same buffer segment
as aplay is writing to. Fixed by using dma residue reporting.

> 
> I have been investigating an issue about sound stability on mx28 as well.
> 
> The usecase I am doing is:
> 
> while true
> do
>     arecord -D hw:0,1 -d 10 -f S16_LE -r 44100 -c 2 | aplay
>     sleep 2
> done
> 
> (Record 10 seconds, sleep and keep in this loop forever).
> 
> The problem I see is that randomly the captured audio becomes
> extremely noisy and loud (throughout the whole 10 seconds) and then in
> the subsequent loop it becomes normal. This is very random and it
> happens at a 1 or 2% failure rate.
> 
> I tested your v3, but it did not help to fix this particular issue.

I think that is another problem independent of the other two issues I
observed. You could try to remove the NO_RESIDUE flag from mxs-pcm which
will enable the use of the residue reporting introduced in this series.
But I don't think it will help.

> 
> I also tried experimenting with the SAIF IOMUX settings:
> 
> index cda19c8..463fa92 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -545,9 +545,9 @@
>                          MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK
>                          MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0
>                      >;
> -                    fsl,drive-strength = <MXS_DRIVE_12mA>;
> +                    fsl,drive-strength = <MXS_DRIVE_4mA>;
>                      fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -                    fsl,pull-up = <MXS_PULL_ENABLE>;
> +                    fsl,pull-up = <MXS_PULL_DISABLE>;
>                  };
> 
>                  saif0_pins_b: saif0 at 1 {
> @@ -557,9 +557,9 @@
>                          MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK
>                          MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0
>                      >;
> -                    fsl,drive-strength = <MXS_DRIVE_12mA>;
> +                    fsl,drive-strength = <MXS_DRIVE_4mA>;
>                      fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -                    fsl,pull-up = <MXS_PULL_ENABLE>;
> +                    fsl,pull-up = <MXS_PULL_DISABLE>;
>                  };
> 
>                  saif1_pins_a: saif1 at 0 {
> @@ -567,9 +567,9 @@
>                      fsl,pinmux-ids = <
>                          MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0
>                      >;
> -                    fsl,drive-strength = <MXS_DRIVE_12mA>;
> +                    fsl,drive-strength = <MXS_DRIVE_4mA>;
>                      fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -                    fsl,pull-up = <MXS_PULL_ENABLE>;
> +                    fsl,pull-up = <MXS_PULL_DISABLE>;
>                  };
> 
> and my tests are showing a much better stability. Not able to get this
> problem after several hours.
> 
> Regards,
> 
> Fabio Estevam
> 

Regards,

Markus Pargmann

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
