From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jun 2014 17:43:38 +0200
Subject: [PATCH 09/16] ARM: mvebu: Make the snoop disable optional in
 mvebu_v7_pmsu_idle_prepare
In-Reply-To: <1403875377-940-10-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-10-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140630174338.13604523@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Fri, 27 Jun 2014 15:22:50 +0200, Gregory CLEMENT wrote:

>  /* No locking is needed because we only access per-CPU registers */
> -static void mvebu_v7_pmsu_idle_prepare(bool deepidle)
> +static void mvebu_v7_pmsu_idle_prepare(bool deepidle, bool snoopdis)

I continue to find it odd to have more and more boolean arguments to a
function to indicate what the function should do. It often indicates
that the function should rather be split in smaller, fine-grained
functions. Another sad consequence of using booleans is that the call
sites of the functions can no longer be understood properly:

	mvebu_v7_pmsu_idle_prepare(false, true);
	mvebu_v7_pmsu_idle_prepare(true, true);
	mvebu_v7_pmsu_idle_prepare(false, false);

But oh well, it looks like it's the easiest solution here, and I admit
it's convenient to have one function to the entire business of
preparing for idle.

However, this change also badly conflicts with the CPU hotplug support
that I have sent, and which is already part of linux-next, and for
which Jason has sent a pull request to the arm-soc folks. See
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm/mach-mvebu/platsmp.c
for the usage of the armada_370_xp_pmsu_idle_enter() function.

Maybe your patch series should be based on mvebu/soc instead?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
