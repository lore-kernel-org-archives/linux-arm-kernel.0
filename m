From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 23 Aug 2013 12:32:30 +0200
Subject: [RFC 08/17] ARM: mvebu: remove custom .init_time hook
In-Reply-To: <52173408.1000702@free-electrons.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-9-git-send-email-sebastian.hesselbarth@gmail.com>
 <52173408.1000702@free-electrons.com>
Message-ID: <52173A3E.2040509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/13 12:06, Gregory CLEMENT wrote:
> On 20/08/2013 04:04, Sebastian Hesselbarth wrote:
>> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
>> remove custom .init_time hooks.
>
> As a feared it won't work on Armada XP. You moved coherency_init(), and
> l2x0_of_init() in the init_machine hook. However init_machine is an
> arch_initcall, and as all the initcall it is called at the end of the
> do_basic_setup() which is called after smp_prepare_cpus(). The issue is
> that smp_prepare_cpus need coherency (and I think L2 cache) already enable.

Ok, I see. I remember mvebu smp relies on mbus mappings also? Can you
try below as replacement for the mach-mvebu/armada-370-xp.c changes?

It will move coherency_init(), l2x0_of_init(), and mvebu_mbus_dt_init()
to .init_early hook.

Sebastian

-------------- next part --------------
A non-text attachment was scrubbed...
Name: arm-of_clk_init-mvebu-proposal.diff
Type: text/x-patch
Size: 1292 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/dee253c6/attachment-0001.bin>
