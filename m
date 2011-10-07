From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Oct 2011 08:42:48 +0200
Subject: [PATCH RESEND] ARM: smp_twd: Reconfigure clockevents after
	cpufreq change
In-Reply-To: <alpine.LFD.2.02.1110061922440.3240@ionos>
References: <1315292775-4413-1-git-send-email-linus.walleij@stericsson.com>
	<CAKnu2ModYp+F0kq6qVo9SQJ88GR_EwGNgH2WZXJrXUeR1xyzQw@mail.gmail.com>
	<alpine.LFD.2.02.1110061922440.3240@ionos>
Message-ID: <CACRpkdaQNA_n7haRCU++26CLuaZ=eRb7iAS+mm0fQV244G1S4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 6, 2011 at 7:25 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 6 Oct 2011, Linus Walleij wrote:
>> Here is the entire patch i Russells tracker:
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2
>
> The only thing what puzzles me is:
>
>> + ? ? if (!IS_ERR_OR_NULL(twd_clk))
>> + ? ? ? ? ? ? twd_timer_rate = clk_get_rate(twd_clk);
>> + ? ? else
>> + ? ? ? ? ? ? twd_calibrate_rate();
>
> How is made sure that the cpu freq update thing is not called when
> twd_clk is not available or am I missing something ?

The CPUfreq transition notifier is only registered if twd_clk is
not error or NULL in this #ifdef CONFIG_CPU_FREQ snippet
above that code, but executed later:

+static int twd_cpufreq_init(void)
+{
+	if (!IS_ERR_OR_NULL(twd_clk))
+		return cpufreq_register_notifier(&twd_cpufreq_nb,
+			CPUFREQ_TRANSITION_NOTIFIER);
+
+	return 0;
+}
+core_initcall(twd_cpufreq_init);

Yours,
Linus Walleij
