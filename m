From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Oct 2013 16:26:36 +0200
Subject: [PATCH v3 05/14] ARM: mvebu: Make ll_set_cpu_coherent() more
 configurable
In-Reply-To: <1381759106-15004-6-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
 <1381759106-15004-6-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20131014162636.1f486053@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:17 +0200, Gregory CLEMENT wrote:
> ll_set_cpu_coherent does two things to set the coherency for a CPU:
> 
> - Adding the CPU to the SMP group 0
> - Enabling the snooping on the CPU
> 
> Only the second part is needed when coming back from a CPU Idle. This
> commit allows to choose to do the first part or not.

I am not a fan of this change: those two boolean arguments are really
mystical. If a function does do things, and sometimes must be called to
do one thing, and sometimes for two things, it is really calling for a
split of the functions (with potentially the second function calling the
first, or the two functions being called in a row when needed).

Let's have two functions:

	ll_set_cpu_smp_group();
	ll_set_cpu_coherent();

at initialization time, both functions are called. On the exit path of
idle, only the second one is called.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
