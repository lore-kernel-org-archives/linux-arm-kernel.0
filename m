From: grant.likely@secretlab.ca (glikely@secretlab.ca)
Date: Sun, 26 Jun 2011 15:24:43 -0600
Subject: "Early" devices and the DT
In-Reply-To: <4E0786FF.9010002@firmworks.com>
References: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
	<1308924659-31894-3-git-send-email-marc.zyngier@arm.com>
	<20110625204742.GB15026@ponder.secretlab.ca>
	<4E06513B.4030706@gmail.com>
	<BANLkTimy6iyQyyvNUK3Kc6skSKyVxBwWPA@mail.gmail.com>
	<4E0786FF.9010002@firmworks.com>
Message-ID: <4f20d688-0cbb-48e7-830c-69cf57d902ba@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Mitch Bradley <wmb@firmworks.com> wrote:

>Some solutions to the early device problem
>
>a) Most complex:  Use new properties to create a dependency graph. 
>This 
>is probably the most general solution, but also probably the hardest
>for 
>people to think about and maintain.
>
>b) Define a set of init phases 0,1,2,...  and mark each early device 
>node with a phase number property.  Scan the tree for each phase and 
>handle only the devices with that phase number.  Unmarked nodes are 
>handled last.
>
>c) Similar to b, but instead of properties in nodes, have properties 
>like "linux-phase0", "linux-phase1", etc in /chosen, whose values are 
>lists of phandles.

d) don't try to encode init order at all in the DT, and let device drivers request probe to be deferred.  If this works out, it will be by far the least complex and won't require anybody to sit and work out the init order for each machine.  I've even already posted a draft patch to do this.

e) work out probe order dynamically by looking at known phandle types at device registration time. This is potentially more 'efficient' than option d, but it requires a lot of knowledge to be built into the registration code which will get really complex in a hurry.

Right now I'm strongly leaning in the direction of option d.

g.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
