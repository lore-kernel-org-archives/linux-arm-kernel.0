From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Sep 2014 10:52:52 +0100
Subject: [PATCH] arm: prevent BUG_ON in audit_syscall_entry()
In-Reply-To: <1409910393-30896-1-git-send-email-takahiro.akashi@linaro.org>
References: <1409910393-30896-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140905095252.GF30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 06:46:33PM +0900, AKASHI Takahiro wrote:
> BUG_ON() in audit_syscall_entry() will be hit if user issues syscall(-1)
> while syscall auditing is enabled (that is, by starting auditd).
> In fact, syscall(-1) just fails (not signaled despite the expectation,
> this is another minor bug), but the succeeding syscall hits BUG_ON.
> 
> When auditing syscall(-1), audit_syscall_entry() is called anyway, but
> audit_syscall_exit() is not called and then 'in_syscall' flag in thread's
> audit context is kept on. In this way, audit_syscall_entry() against
> the succeeding syscall will see BUG_ON(in_syscall).
> 
> This patch fixes this bug by
> 1) enforcing syscall exit tracing, including audit_syscall_exit(), to be
>    executed in all cases,

Really, no.  That adds additional overhead to every syscall, and that
matters for system performance.  We want to have as little as possible
overhead here.

The second issue here is that you haven't explained where the oops
occurs.  It's seen as a good practice to include the oops dump for the
bug you're fixing in the commit changelog, so that others can see the
starting point for the investigation, and see exactly where things are
going wrong.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
