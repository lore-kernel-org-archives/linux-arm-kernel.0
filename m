From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 06 Apr 2015 11:23:14 +0100
Subject: [PATCH/RFC 0/6] staging: board: armadillo800eva: Board staging
 for =?UTF-8?Q?sh=5Fmobile=5Flcdc=5Ffb?=
In-Reply-To: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
Message-ID: <9cb05c4e687de35ada0b83fe816393c8@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 2015-04-03 13:41, Geert Uytterhoeven wrote:
> Hi all,
>
> This RFC patch series adds board staging support for 
> r8a7740/armadillo.
> For now this supports only the frame buffer device for the on-board 
> LCD.
> The goal is to complete the move to ARM multiplatform kernels for all
> shmobile platforms, and drop the existing board files
> (arch/arm/mach-shmobile/board-*).
>
> The board staging area was introduced last year to allow continuous
> upstream in-tree development and integration of platform devices. It
> helps developers integrate devices as platform devices for device
> drivers that only provide platform device bindings.  This in turn 
> allows
> for incremental development of both hardware feature support and DT
> binding work in parallel.
>
> This series consists of 4 parts:
>   - Patch 1 re-enables compilation of the board staging area, which 
> was
>     disabled after a compile breakage, but has been fixed in the mean
>     time,
>   - Path 2 moves initialization of staging board code to an earlier
>     moment, as currently it happens after unused PM domains are 
> powered
>     down,
>   - Patches 3 and 4 (hopefully) fix the existing kzm9d board staging
>     code, which was presumably broken by commit 9a1091ef0017c40a
>     ("irqchip: gic: Support hierarchy irq domain."),

Please allow me a semantic correction here: this commit never broke 
anything. It merely revealed how platform code (OMAP, iMX6, shmobile) 
abused the irq_domain subsystem, hoping to get away with only a partial 
conversion to DT. The platform code itself was broken from the moment it 
used DT to discover its interrupt controller.

The truth is, it is not possible to sanely convert bits of a platform 
to DT. The changes creep into all the subsystems, and doing it in stages 
requires tons of ugly hacks (and I've written my share of them).

That being said, I'm off reviewing these two matches.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
