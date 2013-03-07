From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Mar 2013 03:44:55 +0000
Subject: [RFC PATCH] ARM: keep __my_cpu_offset consistent with generic one
In-Reply-To: <1362624468-5451-1-git-send-email-tom.leiming@gmail.com>
References: <1362624468-5451-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20130307034454.GE25137@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Mar 07, 2013 at 02:47:48AM +0000, Ming Lei wrote:
> Commit 14318efb(ARM: 7587/1: implement optimized percpu variable access)
> introduces arm's __my_cpu_offset to optimize percpu vaiable access,
> which really works well on hackbench test, but may cause __my_cpu_offset
> to return garbage value before it is initialized in cpu_init() called
> by setup_arch, so accessing a percpu variable before setup_arch may cause
> kernel hang. But the generic__my_cpu_offset always returns zero before
> percpu area is brought up.
> 
> So the patch tries to clear __my_cpu_offset on boot CPU early
> to avoid boot hang.
> 
> At least now percpu variable is accessed by lockdep before
> setup_arch(), and enabling CONFIG_LOCK_STAT or CONFIG_DEBUG_LOCKDEP
> can trigger kernel hang.

For the record, can you include a backtrace or something please? The
description makes it sounds like a caller bug, so it would be good to
document a valid user of per-cpu before cpu_init().

Will
