From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 13 Aug 2015 14:47:39 -0700
Subject: [PATCH v5] mtd: spi-nor: add driver for NXP SPI Flash Interface
 (SPIFI)
In-Reply-To: <1439486380-17720-1-git-send-email-manabian@gmail.com>
References: <1439486380-17720-1-git-send-email-manabian@gmail.com>
Message-ID: <20150813214739.GH60523@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 07:19:40PM +0200, Joachim Eastwood wrote:
> Add SPI-NOR driver for the SPI Flash Interface (SPIFI)
> controller that is found on newer NXP MCU devices.
> 
> The controller supports serial SPI Flash devices with 1-, 2-
> and 4-bit width in either SPI mode 0 or 3. The controller
> can operate in either command or memory mode. In memory mode
> the Flash is exposed as normal memory and can be directly
> accessed by the CPU.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
> Hi Brian,
> 
> I skipped the cover letter since you already applied the 2nd
> of patch of the original set and using a cover letter for
> just one patch seemed a bit useless. Cover letter for v4 can
> be found here: http://marc.info/?l=devicetree&m=143647330431908&w=2
> 
> This version address all comments from Brian Norris except
> for two things noted below.
> 
> If the line below is removed the kernel opses on jffs2 mount.
> spifi->mtd.priv  = &spifi->nor;
> It seems like spi-nor.c doesn't setup this field. fsl-quadspi
> also assigns this field, btw.

Sorry, I overlooked that. But that code's pretty dumb. I'll take yours
as-is, but I'll send a patch to fix both.

> The read/wait ordering in nxp_spifi_read_reg is correct. I
> don't really have a good explaination for the ordering. The
> user manual doesn't document the SPIFI in detail, but the
> offcial NXP spifilib has the same ordering.

OK, no problem.

> Changes since v4:
>  - spifi: always autodetect SPI Flash
>  - s/spi/SPI on dev_* output
>  - add parentheses to SPIFI_CMD_DATALEN macro
>  - rebase on mtd-master
> 
> Changes since v3:
>  - fix bug in write function
>  - rebase on 4.2-rc1
> 
> Changes since v2:
>  - default to auto detection unless chip is specified
>  - update doc with reference to jedec,spi-nor.txt
> 
> Test on the following boards.
> Hitex board boots on SPIFI Flash with JFFS2.
> 
> Hitex LPC4350 Eval board:
> [    2.093956] nxp-spifi 40003000.spifi: s25sl064p (8192 Kbytes)
> 
> Embedded Artists' LPC4357 Developer's Kit:
> [    3.051627] nxp-spifi 40003000.spifi: s25fl016k (2048 Kbytes)

Applied to l2-mtd.git, thanks!

BTW, is this driver worth a MAINTAINERS entry? It's nice to always have
someone on CC that has the hardware. The git history should probably
pick you up anyway when running get_maintainers.pl, so it may not be
absolutely necessary.

> Both s25fl016k and s25sl064p support dual/quad mode, but this
> is not flagged in spi-nor.c. I have sent a patch for s25fl016k
> and will send a patch s25sl064p please apply when you get them.

I'll see if I can dig these out of the mailing list eventually. I have a
sizable backlog.

Brian
