From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 24 Jul 2013 17:00:28 +0000 (UTC)
Subject: [PATCH v2] ARM: Do not run dummy_flush_tlb_a15_erratum() on
 non-Cortex-A15
In-Reply-To: <1374581199-8277-1-git-send-email-festevam@gmail.com>
References: <1374581199-8277-1-git-send-email-festevam@gmail.com>
Message-ID: <alpine.DEB.2.02.1307241700010.13653@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jul 2013, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15 erratum 798181 
> (TLBI/DSB operations)) causes the following undefined instruction error on a
> mx53 (Cortex-A8):
> 
> Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> CPU: 0 PID: 275 Comm: modprobe Not tainted 3.11.0-rc2-next-20130722-00009-g9b0f371 #881
> task: df46cc00 ti: df48e000 task.ti: df48e000
> PC is at check_and_switch_context+0x17c/0x4d0
> LR is at check_and_switch_context+0xdc/0x4d0
> 
> This problem happens because check_and_switch_context() calls 
> dummy_flush_tlb_a15_erratum() without checking if we are really running on a 
> Cortex-A15 or not. 
> 
> To avoid this issue, only call dummy_flush_tlb_a15_erratum() inside 
> check_and_switch_context() if erratum_a15_798181() returns true, which means
> that we are really running on a Cortex-A15.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Tested-by: Paul Walmsley <paul@pwsan.com> # for OMAP2,3,4,AM33xx

Fixes the v3.11-rc boot regression that broke multiple boards.

- Paul
