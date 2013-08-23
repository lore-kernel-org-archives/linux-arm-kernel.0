From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 22 Aug 2013 17:59:36 -0700
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
Message-ID: <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 05:26:47PM -0700, S?ren Brinkmann wrote:
> Hi Sebastian,
> 
> On Tue, Aug 20, 2013 at 04:04:31AM +0200, Sebastian Hesselbarth wrote:
> > With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> > remove it from corresponding drivers/clk code.
> 
> I think that would break Zynq.
> If I see this correctly you call of_clk_init() from common code,
> _before_ the SOC specific time init function is called.
> The problem is, that we have code setting up a global pointer which is
> required by zynq_clk_setup() which is triggered when of_clk_init() is
> called.
> 
> Let me try to illustrate the current call graph:
> 
> time_init()
> 	zynq_timer_init()		// this machines init_time()
> 		zynq_slcr_init()	// setup System Level Control Registers including a global pointer
> 			zynq_clock_init()
> 				of_clk_init()
> 					zynq_clk_setup()   // requires pointer setup in zynq_slcr_init()
> 					...
> 
> IIUC, your series would change this to:
> time_init()
> 	of_clk_init()
> 		zynq_clk_setup()	// SLCR pointer is not setup/NULL
> 		...
> 	zynq_timer_init()
> 		zynq_slcr_init()	// now the pointer becomes valid

I guess we could move zynq_slcr_init() into init_irq(). I'll give that a
shot tomorrow.

	S?ren
