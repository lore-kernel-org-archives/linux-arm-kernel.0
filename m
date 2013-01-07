From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jan 2013 14:48:13 +0000
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <87ehhxahd1.fsf@xmission.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
 <50E5E967.3020805@wwwdotorg.org>
 <20130106162200.GC11025@mudshark.cambridge.arm.com>
 <20130106164033.GA3222@n2100.arm.linux.org.uk> <87ehhxahd1.fsf@xmission.com>
Message-ID: <20130107144812.GD3222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 06, 2013 at 05:53:30PM -0800, Eric W. Biederman wrote:
> I have cleaned up the mess that is the reboot path once a bunch of years
> ago, and apparently it is deteriorating again.

Unfortunately, that's what happens when lots of cooks get their fingers
in a pie with no coordination.  This is why having maintainers is soo
important for code - a good maintainer ensures that the code remains
high quality by whatever means.

Code without maintainers is subject to modification in all kinds of
random ways, including duplicating code amongst architectures which
should be generic code - that happens because no one wants to understand
what other architectures require.

Your original cleanups, afaik, are still all intact.  The problem is
that since then, kexec has come along, and invented a new callback
(machine_shutdown) which gets called while the system is still live
in full SMP mode (and presumably all the devices are still running
and potentially scribbling over memory with their DMA.)  Meanwhile
kexec wants to pass control to the new kernel... that doesn't sound
particularly clever to me.
