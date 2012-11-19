From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 12:16:32 +0000
Subject: [RFC PATCH 3.7.0-rc4] ARM:smp: introduce smp_notify_cpu_stop to
 fix kexec smp case
In-Reply-To: <50AA211D.20005@st.com>
References: <1353003478-22291-1-git-send-email-srinivas.kandagatla@st.com>
 <20121115211833.GD13998@mudshark.cambridge.arm.com>
 <50A5FBB7.9040001@st.com>
 <20121119105848.GF3205@mudshark.cambridge.arm.com>
 <50AA211D.20005@st.com>
Message-ID: <20121119121632.GM3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 12:07:57PM +0000, Srinivas KANDAGATLA wrote:
> On 19/11/12 10:58, Will Deacon wrote:
> > On Fri, Nov 16, 2012 at 08:39:19AM +0000, Srinivas KANDAGATLA wrote:
> >> On 15/11/12 21:18, Will Deacon wrote:
> >>>  The bigger issue is co-ordinating with the
> >>> secondaries so you know when they're safely out of the way and you can
> >>> proceed with the kexec. Remember that you won't have working locks and you
> >>> can't cross-call a function because it won't actually return.
> >> Yes I agree and understand the limitation.
> >> The callback should simple and just relocate the secondary core to a
> >> safe place which in our case is a holding pen, which is safe and not in
> >> the system ram.
> >> After the callback, the secondary core will be spinning in the holding
> >> pen which will be released once they get a matching cpu-id.
> >> And this approach works perfectly ok on our chips and I guess should
> >> work for other chips aswell.
> > But how do you know when the callback is complete? That's the part that is
> > tricky as you need to avoid clobbering the kernel image before you know for
> > sure that all the secondaries are out of the way.
> Yes, there is a very small window of opportunity for the primary core to
> continue with new kernel image.

It might not be that small, particulary if the secondaries are doing
something with interrupts disabled and the signal from the primary is
delayed.

> We have two options here:
> 
> 1> I think the existing infrastructure of cpu_kill can be re-used to
> know if the callback is complete and is very much specific to platform
> implementation.

How? I would just like a description of one concrete implementation so that
I know we're adding something which is actually usable.

> 2> Add a is_cpu_stopped() in smp_operations and call it from primary
> core with cpu set to secondary cores, similar to smp_kill_cpus call.
> This is also specific to platform implementation.

Again, how does is_cpu_stopped() work? I'm not even sure we can guarantee
coherency on this path.

Perhaps it's best if you include these patches with the platform support for
a board that uses it, then we can see the bigger picture.

Will
