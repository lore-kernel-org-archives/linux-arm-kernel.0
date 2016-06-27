From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 27 Jun 2016 08:28:20 +0200
Subject: [v2] media: rc: fix Meson IR decoder
In-Reply-To: <20160626210622.5257-1-martin.blumenstingl@googlemail.com>
References: <20160626210622.5257-1-martin.blumenstingl@googlemail.com>
Message-ID: <5770C784.6040604@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/26/2016 11:06 PM, Martin Blumenstingl wrote:
> The meson-ir driver uses the wrong offset (at least according to
> Amlogic's reference driver as well as the datasheets of the
> Meson8b/S805 and GXBB/S905).
> This means that we are getting incorrect durations (REG1_TIME_IV)
> reported from the hardware.

Hi,

I'm quite sure the registers are good for meson6 actually, and
it seems reasonable Amlogic made the HW evolve for the Meson8 and GXBB platforms.

>
> This problem was also noticed by some people trying to use this on an
> ODROID-C1 and ODROID-C2 - the workaround there (probably because the
> datasheets were not publicy available yet at that time) was to switch
> to ir_raw_event_store_edge (which leaves it up to the kernel to measure
> the duration of a pulse). See [0] and [1] for the corresponding
> patches.

Since we are using devicetree, the correct way to achieve this fix is not
to drop support for meson6 (what you do) but add a logic to select the correct
register for meson8 and gxbb if their compatible string are encountered.

> Please note that I was only able to test this on an GXBB/S905 based
> device (due to lack of other hardware).

I made this fix already but lacked time to actually test it on HW :
https://github.com/torvalds/linux/compare/master...superna9999:amlogic/v4.7/ir

My patch is missing the meson8b support, and may need a supplementary compatible check or
a separate dt match table.

Neil

>
> [0] https://github.com/erdoukki/linux-amlogic-1/commit/969b2e2242fb14a13cb651f9a1cf771b599c958b
> [1] http://forum.odroid.com/viewtopic.php?f=135&t=20504
>

PS: BTW could you format the cover letter using the git format-patch --cover-letter instead and
add the v2 using the -subject-prefix like :
# git format-patch --cover-letter --signoff --subject-prefix "PATCH v2" -2

> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>
