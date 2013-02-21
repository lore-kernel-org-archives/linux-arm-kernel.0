From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Feb 2013 11:31:31 +0000
Subject: [PATCH] ARM: smp_twd: change WARN() to pr_warn() on local
 timer register failure
In-Reply-To: <1361435877-27252-1-git-send-email-shawn.guo@linaro.org>
References: <1361435877-27252-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130221113131.GZ17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 04:37:57PM +0800, Shawn Guo wrote:
> When booting a SMP build kernel with nosmp on kernel cmdline, the
> following fat warning will be hit.  Since the local timer registeration
> failure is expected for such boot condition, a normal pr_warn message
> should be good enough for the failure.

Yes, a pr_warn here would be better.  However, you're still going to end
up with a warning because we don't support this on UP.

The reason you don't get a warning when you build for UP is this:

#ifdef CONFIG_HAVE_ARM_TWD
void twd_local_timer_of_register(void);
#else
static inline void twd_local_timer_of_register(void)
{
}
#endif

twd_local_timer_of_register() becomes a no-op.

I think a better solution may be to also replicate this check:

	if (!is_smp() || !setup_max_cpus)

in twd_local_timer_of_register() so that it also becomes a no-op.
