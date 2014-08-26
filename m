From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Aug 2014 12:36:09 +0100
Subject: [PATCH] ARM: errata: Workaround for Cortex-A12 erratum 818325
In-Reply-To: <20140826101414.GD23445@arm.com>
References: <1408355889-4176-1-git-send-email-kever.yang@rock-chips.com>
 <20140826101414.GD23445@arm.com>
Message-ID: <20140826113609.GV30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:14:14AM +0100, Will Deacon wrote:
> On Mon, Aug 18, 2014 at 10:58:09AM +0100, Kever Yang wrote:
> > From: Huang Tao <huangtao@rock-chips.com>
> > 
> > On Cortex-A12 (r0p0..r0p1-00lac0-rc11), when a CPU executes a sequence of
> > two conditional store instructions with opposite condition code and
> > updating the same register, the system might enter a deadlock if the
> > second conditional instruction is an UNPREDICTABLE STR or STM
> > instruction. This workaround setting bit[12] of the Feature Register
> > prevents the erratum. This bit disables an optimisation applied to a
> > sequence of 2 instructions that use opposing condition codes.
> > 
> > Signed-off-by: Huang Tao <huangtao@rock-chips.com>
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > ---
> 
> The Rk3288 I have advertises itself as an r0p1 Cortex-A12 CPU, so isn't
> affected by this issue. Until we have an SoC supported in mainline that
> requires this workaround, I don't think we should merge it.
> 
> Also, please consider setting these bits in your firmware if possible.
> The feature register isn't writable from the non-secure side, so if you
> want to use virtualisation you'll need to do this differently.

I think we're at the point where we start insisting that workarounds
which are simple enable/disable feature bit operations (in other words,
which can be handled by updating a control register in the firmware or
boot loader) must be done that way, and we are not going to add such
workarounds to the kernel anymore.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
