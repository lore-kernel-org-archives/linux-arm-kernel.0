From: roger.pau@citrix.com (=?UTF-8?Q?Roger_Pau_Monn=c3=a9?=)
Date: Tue, 6 Oct 2015 11:28:08 +0200
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <1442919576.10338.146.camel@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com> <55F6C1D2.7010206@citrix.com>
 <55F6D9DC.8060607@citrix.com>
 <alpine.DEB.2.02.1509141542430.2672@kaball.uk.xensource.com>
 <55F6E658.4070908@citrix.com> <1442919576.10338.146.camel@citrix.com>
Message-ID: <56139428.4050402@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 22/09/15 a les 12.59, Ian Campbell ha escrit:
> On Mon, 2015-09-14 at 17:23 +0200, Roger Pau Monn? wrote:
>> I'm not saying that we shouldn't take those patches, I'm just saying
>> that IMHO this is a workaround, and I would like to see a plan and
>> somebody committed to have it fixed in a proper way, by introducing a
>> 64KB PV block protocol.
> 
> In my view the basic unit of operation for all Xen interfaces (on x86 and
> arm at least[0]) is 4K. The peer at either end of a PV protocol should
> therefore be entitled to assume that at a minimum the other end supports
> operation in 4K mode (i.e. 4K is the baseline).
> 
> Operations in larger sizes (which would necessarily be multiples of 4K) are
> then an extension which is subject to a negotiation between the two ends,
> it doesn't really matter if those larger sizes arise because of the use of
> superpages or because the guest is internally using some larger basic page
> size (which ARM calls a "granule", and where 64K comes from here).
> 
> I think this line of reasoning applies just as strongly to the hypercall
> ABI as well BTW, they all use 4K as their basic unit, but might support
> extensions to operation on multiples of that (negotiated either via a
> specific error return and fallback or via the use of XENFEAT).

Yes, I completely agree that the current Xen interface is based on 4KB
chunks. What I'm trying to say is that the approach taken, which is
"let's not modify Xen" puts all the burden on the guest and it is going
to hurt us in the long run.

Are we expecting all guests that want to use 64KB page to implement all
the modifications that are needed? IMHO, those modifications are very
far from trivial, and we are putting the bar for Xen guest support very
high, and that is wrong. We are already struggling to have a decent set
of PV drivers on guests different than Linux, and this is certainly not
making things easier.

Do KVM guests also need such extensive set of modifications in order to
run using 64KB pages? I know it's not fair to compare KVM and Xen in
this regard, because the interfaces are very different, but that's what
developers are going to look at.

Roger.
