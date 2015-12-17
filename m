From: courtney.cavin@sonymobile.com (Courtney Cavin)
Date: Wed, 16 Dec 2015 16:01:41 -0800
Subject: [PATCH] net: add Qualcomm IPC router
In-Reply-To: <20151215.160114.1178824607335349574.davem@davemloft.net>
References: <1449866519-14551-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20151215.160114.1178824607335349574.davem@davemloft.net>
Message-ID: <20151217000141.GG28026@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 10:01:14PM +0100, David Miller wrote:
> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Date: Fri, 11 Dec 2015 12:41:59 -0800
> 
> > +static unsigned int qrtr_local_nid = 1;
> > +module_param_named(node_id, qrtr_local_nid, uint, S_IRUGO);
> > +MODULE_PARM_DESC(idVendor, "Local Node Identifier");
> 
> Module parameters suck.
> 
> Allow the user to choose this dynamically.  You have roughtly two choices.
> 
> 1) Subvert the 'protocol' field passed to ->create() and use that, it is
>    being ignored otherwise.
> 
> 2) Put it into the socket address for bind().

So each socket can have its own node id?  That doesn't seem right.

The way these node ids are assigned is by a system designer (in this
case Qualcomm).  The ARM, Linux CPU is always node 1, the audio DSP is
always node 5, etc.  Anyone with the knowhow could reassign these
numbers, but there's no reason to have them be dynamic during runtime.
Additionally, allowing dynamic assignment would require code to prevent
id duplication for known remote nodes, as well as to deal with cases in
which remote node discovery happens after local sockets have acquired
that node's id.

Maybe the first socket created needs CAP_NET_ADMIN, and uses the
'protocol' field to set the node id?  Ugh. Gross.

We could hardcode the value in kconfig, but that seems like a worse
solution than a module parameter.

I'm open to further suggestions.

-Courtney
