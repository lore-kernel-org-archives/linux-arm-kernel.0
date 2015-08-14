From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Aug 2015 15:05:21 +0200
Subject: [linux-sunxi] [RFC PATCH 0/6] mtd: nand: per-partition ECC config
In-Reply-To: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <55CDE791.8030306@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 30-07-15 15:50, Boris Brezillon wrote:
> Hello,
>
> It's been a year and a half since I posted my first series proposing
> an approach to support per-partition ECC config [1].
>
> First of all, before describing what's done in this patch series, I'd
> like to sum-up why this is needed, and why a generic approach is
> preferred over a NAND controller specific one.
> On one side we have a lot of NAND chips out there and they all have
> their own requirements in term of ECC strength and step size. On the
> other side, most SoCs support booting from NAND (they embed a simple
> logic in the ROM code to access a NAND chip through their NAND
> controller).
> In a ideal world all NAND chips would use the ONFI or JEDEC standard
> exposing their requirements in a standard way, and the SoC vendors
> would put the ONFI and JEDEC detection code in their ROM code and use
> it to properly configure their NAND controller.
> But we're not leaving in an ideal world, and some SoC vendors have
> decided to hardcode (or use a simplified logic) to select the ECC
> controller config. And in the case where the NAND requirement does
> not match the ROM code config, you only have two solutions:
>
> 1/ leave with the unsuitable ECC config for the whole chip
> 2/ isolate the portion of NAND read by the ROM code into a sperate
>     partition and use a suitable ECC config for the rest of the
>     NAND
>
> IMHO the second solution is far better than the first one, but it
> requires some adjustments in the mtdpart and NAND code layer to be
> applicable.
>
> Now, why should we prefer a generic approach over a NAND controller/SoC
> specific one ?
> Because, this seems to be a problem faced by other people on other
> platform than the sunxi one. Moreover, the ECC config is not the only
> thing we'd have to tweak per partition: I'm currently working on the
> NAND randomizer/scrambler aspect (required to support some MLC chips),
> and this is also something the ROM code configure differently to
> boot the first stage bootloader.
> For all these reasons, I think providing a generic infrastructure allowing
> specific implementation to tweak their behavior is better than hardcoding
> it somewhere in the NAND controller driver.
>
> This series proposes a solution to allow such per-partition config by
> first letting MTD implementations (or subframework) overload the MTD
> partition functions (patches 1 and 2), and then providing the appropriate
> modifications in the NAND layer to support per-partition ECC config
> (patches 3 to 5).
> The last patch is showing how a NAND controller can add support for
> per-partition ECC config.
>
> Note that I tried to keep the changes as less invasive as impossible, but
> I might have missed some aspects.
> Any suggestions are welcome.
>
> Best Regards,
>
> Boris

Thanks for doing this, this series looks good to me.

MTD maintainers, what do we need to do to get this upstream, submit
a non RFC version ? Or ... ?

Regards,

Hans
