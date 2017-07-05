From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 04 Jul 2017 19:36:32 -0700
Subject: [PATCH] ARM: owl: smp: Drop owl_secondary_boot()
In-Reply-To: <20170704233219.18790-1-afaerber@suse.de>
References: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
 <20170704233219.18790-1-afaerber@suse.de>
Message-ID: <3F3740FC-3873-4C01-A625-C8DC7F50A018@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On July 4, 2017 4:32:18 PM PDT, "Andreas F?rber" <afaerber@suse.de> wrote:
>Commit 18cfd9429d8a82c49add8f3ca9d366599bfcac45 ("ARM: owl: smp: Drop
>bogus holding pen") simplified the S500 SMP code by removing a loop for
>pen_release in owl_secondary_boot(). Since then it is only calling
>owl_v7_invalidate_l1() before branching to secondary_startup().
>
>The owl_v7_invalidate_l1() assembler function is superfluous, too.
>Therefore drop owl_secondary_boot() and use secondary_boot() directly.
>
>Cc: David Liu <liuwei@actions-semi.com>
>Signed-off-by: Andreas F?rber <afaerber@suse.de>
>---

>-	writel(virt_to_phys(owl_secondary_startup),
>+	writel(virt_to_phys(secondary_startup),
> 	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);

This is a kernel symbol so please use __pa_symbol() here, also you might want to build with CONFIG_DEBUG_VIRTUAL and see if you get other warnings about using virt_to_phys() in the owl platform code (I did not check if there are other uses)

-- 
Florian
