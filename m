From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 15:38:01 +0000
Subject: [PATCHv5 16/16] clocksource: arch_timer: use virtual counters
In-Reply-To: <1359634539-9580-17-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-17-git-send-email-mark.rutland@arm.com>
Message-ID: <20130131153801.GM12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:15:39PM +0000, Mark Rutland wrote:
> Switching between reading the virtual or physical counters is
> problematic, as some core code wants a view of time before we're fully
> set up. Using a function pointer and switching the source after the
> first read can make time appear to go backwards, and having a check in
> the read function is an unfortunate block on what we want to be a fast
> path.
> 
> Instead, this patch makes us always use the virtual counters. If we're a
> guest, or don't have hyp mode, we'll use the virtual timers, and as such
> don't care about CNTVOFF as long as it doesn't change in such a way as
> to make time travel backwards. If we do have hyp mode, and might be a
> KVM host, we have to use the physical timers, and require CNTVOFF to be
> zero so as to have a consistent view of time between the physical timers
> and virtual counters.
> 
> Any code which may want to alter CNTVOFF (e.g. KVM) will need to ensure
> that it is zeroed when entering the host.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
