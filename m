From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Fri, 14 Feb 2014 17:22:15 -0800
Subject: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <20140214112756.GA25043@e102568-lin.cambridge.arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140213013153.18853.21632@capellas-linux>
 <20140213124731.GD26329@e102568-lin.cambridge.arm.com>
 <20140214002926.1014.3599@capellas-linux>
 <20140214112756.GA25043@e102568-lin.cambridge.arm.com>
Message-ID: <20140215012215.11460.5931@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lorenzo Pieralisi (2014-02-14 03:27:56)
> On Fri, Feb 14, 2014 at 12:29:26AM +0000, Sebastian Capella wrote:
> > Quoting Lorenzo Pieralisi (2014-02-13 04:47:32)
> > 
> > > Such as ? "idle-states" ?
> > 
> > That sounds good to me.  Our preference is for idle-states to be used
> > for name of the idle-states.txt node.
> 
> Ok, so s/cpu-idle-state/idle-state everywhere, inclusive of state nodes
> compatible properties ("arm,cpu-idle-state" becomes "arm,idle-state") ?

No, we were looking to make sure that the cpu-idle-states defined in
cpus.txt:

- cpu node
   - cpu-idle-states

And the cpu-idle-states defined in idle-states.txt:

- cpu-idle-states node

Did not use the same name, and instead had different, unique names.

Our preference was to change only the idle-states.txt name.

> I do not like that, but I can remove the naming scheme and let people
> find a naming scheme that complies with DT rules (nodes within a parent
> must have a unique name). Not sure this would make dts more readable, but
> I do not think it is a problem either.

In the current implementation for cpuidle, we have a descriptive c-state
name.  As long as we can get this kind of functionality using the node
name this seems fine to me.

> That's exactly what these bindings are meant to describe too and I think they
> do. There is also loads of information that can be used for tuning (what
> caches are affected by an idle state, what CPUs "share" an idle-state
> and so on).

Great :)

> > > 
> > > > Definition: It represents an idle state index.
> > > > 
> > > >         Index 0 and 1 shall not be specified and are reserved for ARM
> > > >         states where index 0 is running, and index 1 is idle_standby
> > > >         entered by executing a wfi instruction (SBSA,[3])
> > > > 
> > > > What mechanism is used to order the power states WRT power consumption?
> > > 
> > > I think we should use index for that. The higher the index the lower the
> > > power consumption.
> > 
> > Ok, I think I get it now.
> > If we decouple index and SBSA states, do we really need to reserve index
> > 0 and 1 then?
> 
> What I will do: move the entry-method to top-level cpu-idle-states node
> (soon to be idle-states node) and add a property there:
> 
> "arm,has-idlewfi"
> 
> which allows me to prevent people from adding an explicit state that just
> executes the wfi instruction on entry.
> 
> This way we can have a *global* entry-method, and we can also detect if the
> platform supports wfi in its bare form.
> 
> Yes, index can start from 0, disallowing 0 and 1 was a (odd) way to prevent
> people from adding wfi to DT. If the platform supports simple idlestandby
> (ie wfi) it has to add the boolean property above.
> 
> How does that sound ?

In general I'm ok with indexing as you have it, even if only to specify
an ordering of states by power.  I even thought maybe you could call it
order or sort-order or something, to help people understand you won't
use it as an array index or name, but I don't think it's a big deal
either way.

Do platforms remove support for WFI?  If they do, is this detectible
somehow directly from the ARM without relying on DTS?  It seems like
a comment is enough to discourage people from defining a wfi state.
Then eventually implement a common code path for idle.  I'm fine not
specifying this flag, but if you feel it can be useful I don't object.


> > Should we not allow more flexibility here to mix methods where some
> > states use one method and some use others?  Is this mostly a security
> > concern?  What if a vendor wants to introduce a state between wfi and
> > cpu-sleep?
> 
> entry-method-param is the way to differentiate. One interface/entry-method
> (PSCI or vendor specific), different state parameters.
> 
> We are not installing multiple back-ends to enter different idle states,
> are we ? That would be awkward.
> 
> ACK ?

ACK, thanks!

Sebastian
