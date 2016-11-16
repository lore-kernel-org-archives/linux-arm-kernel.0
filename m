From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Nov 2016 20:23:31 +0100
Subject: [PATCH v3 0/3] modversions: Fix CRC mangling under
 CONFIG_RELOCATABLE=y
In-Reply-To: <1477585631-18574-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1477585631-18574-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161116192331.2jwpewu33dwji3fa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 05:27:08PM +0100, Ard Biesheuvel wrote:
> This series is a followup to the single patch 'modversions: treat symbol
> CRCs as 32 bit quantities on 64 bit archs', of which two versions have
> been sent out so far [0][1]
> 
> As pointed out by Michael, GNU ld behaves a bit differently between arm64
> and PowerPC64, and where the former gets rid of all runtime relocations
> related to CRCs, the latter is not as easily convinced.
> 
> Patch #1 fixes the issue where CRCs are corrupted by the runtime relocation
> routines for 32-bit PowerPC, for which the original fix was effectively
> reverted by commit 0e0ed6406e61 ("powerpc/modules: Module CRC relocation fix
> causes perf issues")
> 
> Patch #2 adds handling of R_PPC64_ADDR32 relocations against the NULL .dynsym
> symbol entry to the PPC64 runtime relocation routines, so it is prepared to
> deal with CRCs being emitted as 32-bit quantities.
> 
> Patch #3 is the original patch from the v1 and v2 submissions.

Is this related to me seeing 

[    2.111424] mvneta: module verification failed: signature and/or required key missing - tainting kernel
[    2.126061] scsi_mod: no symbol version for _clear_bit
[    2.131257] scsi_mod: Unknown symbol _clear_bit (err -22)
[    2.138093] mvneta: no symbol version for _clear_bit
[    2.143117] mvneta: Unknown symbol _clear_bit (err -22)
[    2.144135] mvmdio: no symbol version for __gnu_mcount_nc
[    2.144138] mvmdio: Unknown symbol __gnu_mcount_nc (err -22)
...

? If so, this would be great to mention it in the commit log to make
people searching for this issue actually find this patch set.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
