From: ccross@google.com (Colin Cross)
Date: Sun, 13 Feb 2011 13:59:54 -0800
Subject: [PATCH 6/6] ARM: pm: allow generic sleep code to be used with SMP
	CPU idle
In-Reply-To: <E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTimmSbs7Q_068ERWeKUFV_1Fyxvj37e3r21LZYCL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 8:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Allow the generic sleep code to be used with SMP CPU idle by storing
> N CPU stack pointers rather than just one.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/kernel/sleep.S | ? 26 +++++++++++++++++++++++++-
> ?1 files changed, 25 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 9f106fa..e10618f 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S

<snip>

> @@ -107,4 +129,6 @@ ENTRY(cpu_resume)
> ?ENDPROC(cpu_resume)
>
> ?sleep_save_sp:
> - ? ? ? .word ? 0 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ preserve stack phys ptr here
> + ? ? ? .rept ? CONFIG_NR_CPUS
> + ? ? ? .long ? 0 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ preserve stack phys ptr here
> + ? ? ? .endr

This doesn't compile on CONFIG_SMP=n, CONFIG_NR_CPUS is undefined.
Including linux/threads.h will provide a default definition.
