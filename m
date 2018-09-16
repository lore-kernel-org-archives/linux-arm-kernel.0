From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 16 Sep 2018 13:23:28 +0000
Subject: [PATCH V5 2/5] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <AM0PR04MB4211DE42F39592DF40E91C1080040@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <1534781305-4770-3-git-send-email-aisheng.dong@nxp.com>
 <20180910084042.3zihiimzrvappdjj@pengutronix.de>
 <AM0PR04MB42114BE452BB4305A3EBE9DF80050@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180910121152.qyuuwxqesznzac7t@pengutronix.de>
 <AM0PR04MB4211DE42F39592DF40E91C1080040@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB4211D9BF36DC5C520F18D242801F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> -----Original Message-----
> From: A.s. Dong

[...]

> > > > You export a sc_ipc_open() but it's only ever used once, in your
> > > > internal
> > code.
> > > > Every other user uses sc_ipc_get_handle() which returns the same
> > > > global handle for every user. In fact, I think sc_ipc_open()
> > > > *can* only be used once, because every other user would get -EBUSY
> > > > when requesting the same mailboxes again.
> > > >
> > > > Please drop all this pseudo resource management nonsense. You
> > > > simply do no resource management. Face it, there is only one
> > > > global handle that is used, don't try to hide it.
> > > >
> > >
> > > The original purpose of this code is that there're 5 MUs can be used
> > > by the system, that means other users can choose to not use the
> > > default SCU MU. So sc_ipc_open() may not be used only once.
> > > e.g.
> > > SCU MU1 sc_ipc_open()
> > > CLK MU1 sc_ipc_get_handle()
> > > Power Domain MU2 sc_ipc_open()
> > > Pinctrl MU3 sc_ipc_open()
> > > and etc...
> >
> > Your code started by busy polling the MU units until it would send an answer.
> > The communication is completely synchronous and on the SCU side we
> > have a single core cortex M4 processor. Why should we use another SCU
> > channel? I bet the SCU side services the MUs round robin, so changing
> > the MU won't change much.
> 
> I carefully went through our SCU side code, SCU messages are completely
> handled asynchronously by interrupt driven and it does not have to wait for
> one SCU Message to be completed handled before being able to handle the
> next one.
> 
> The pseudo-code is like:
> Handle_mu_irq()
> {
> 	For (mu = 0; mu < NUM_MU; mu++) {
> 		If (mu_pending()) {
> 			Read(mu); // if available
> 			Handle(mu); //if rx done
> 			Write(mu);
> 		}
> 	}
> 	...
> }
> 
> That means Read and Write process for all MUs channels can be processed
> sequentially within one IRQ, Don't have to wait one of them to be fully
> completed first.
> 
> For example, the follow could be:
> MU IRQ #0 -> Read MU0 word 0-1 -> Read MU1 word 0-2 -> Read MU2 word 0
> -> Exit.
> MU IRQ #1 -> Read MU0 word 2 -> Read MU1 word 3 -> Handle MU1 -> Write
> MU1
> 		 -> Read MU2 word 1 -> Exit.
> MU IRQ #2 -> Read MU0 word 3 -> Handle MU0 -> Write MU0 -> Read MU2
> word 2
> 		 -> Handle MU2 -> Write MU2 -> Exit.
> (Assume MU0 msg size 4, MU1 msg size 4, MU2 msg size 3)
> 
> But if we only support one SCU MU in kernel, then all SCU messages must be
> handled one by one. So it seems like using multiple SCU MUs in kernel are still
> better than using a single one. Am I understand correct?
> 
> Furthermore, If I understand correct, even SCU msg are processed one by one
> in SCU side.
> Using multiple channels in kernel side still can improve the performance a bit
> in theory Because it saves the MU lock contention time. Just like the Async
> request feature supported By MMC subsystem(saving MMC command prepare
> time asynchronously). And multiple MU channels actually are better because
> they're individual instances than mmc controller.
> 

Would you mind give some hints about this?
Can you help clarify a bit if you still think we don't need support multi channels
In kernels regardless of the performance issue?
Then I can just drop it and go ahead.

Regards
Dong Aisheng
