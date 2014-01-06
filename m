From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Jan 2014 17:09:12 +0100
Subject: [PATCH v5 4/4] ARM: BCM5301X: workaround suppress fault
In-Reply-To: <1388965601-18329-5-git-send-email-hauke@hauke-m.de>
References: <1388965601-18329-1-git-send-email-hauke@hauke-m.de>
 <1388965601-18329-5-git-send-email-hauke@hauke-m.de>
Message-ID: <201401061709.13217.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 January 2014, Hauke Mehrtens wrote:
> Without this patch I am getting a unhandled fault exception like this
> one after "Freeing unused kernel memory":
> 
> Freeing unused kernel memory: 1260K (c02c1000 - c03fc000)
> Unhandled fault: imprecise external abort (0x1c06) at 0xb6f89005
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007
> 
> The address which is here 0xb6f89005 changes from boot to boot, with a
> new build the changes are bigger. With kernel 3.10 I have also seen
> this fault at different places in the boot process, but starting with
> 3.11 they are mostly occurring after the "Freeing unused kernel memory"
> message. I never was able to completely boot to userspace without this
> handler. The abort code is constant 0x1c06. This fault just happens
> once in the boot process I have never seen it happing twice or more.
> 
> I also tried changing the CPSR.A bit to 0 in init_early, with this code
> like Afzal suggested, but that did not change anything:
> asm volatile("mrs r12, cpsr\n"
>         "bic r12, r12, #0x00000100\n"
>         "msr cpsr_c, r12" ::: "r12", "cc", "memory");
> 
> Disabling the L2 cache by building with CONFIG_CACHE_L2X0 unset did not
> help.
> 
> This workaround was copied from the vendor code including most of the
> comments. It says it they think this is caused by the CFE boot loader
> used on this device. I do not have any access to any datasheet or
> errata document to check this.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
