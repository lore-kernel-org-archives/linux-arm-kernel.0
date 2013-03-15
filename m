From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 16:59:47 +0000
Subject: [RFC 1/1] clk: Add notifier support in
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <514003B6.8020904@wwwdotorg.org>
References: <1363091861-21534-1-git-send-email-bilhuang@nvidia.com>
 <20130312134032.GU4977@n2100.arm.linux.org.uk>
 <1363139273.21694.11.camel@bilhuang-vm1> <514003B6.8020904@wwwdotorg.org>
Message-ID: <20130315165947.GL4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 10:42:30PM -0600, Stephen Warren wrote:
> I believe the point Russell is making is not that the idea behind this
> patch is wrong, but simply that the function where you put the hooks is
> wrong. The hooks should at least be in clk_enable/clk_disable and not

Indeed, remembering that clk_enable/clk_disable can be called from
atomic contexts.

If the hook needs to be non-atomic (iow, it can schedule) then it can't
go into clk_enable/clk_disable, and must go into clk_prepare/clk_unprepare,
which is the schedulable half of that API.
