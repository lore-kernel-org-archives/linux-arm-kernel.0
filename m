From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 13:47:09 +0000
Subject: [PATCH v4 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <CAH8gqwVHc9ROQYZNe6b-cUN0ycWhYj8=vJ0geBXUCYN1+XENQA@mail.gmail.com>
References: <20111223131851.GB13175@sirena.org.uk>
 <20111224085539.GA1892@richard-laptop> <20111224122411.GA13778@sirena.org.uk>
 <20111224132831.GB1803@richard-laptop>
 <20111224134227.GA20908@opensource.wolfsonmicro.com>
 <20111224155227.GC1803@richard-laptop>
 <20111226111030.GC8722@opensource.wolfsonmicro.com>
 <20111226134449.GA4259@richard-laptop>
 <20120103090625.GA2914@n2100.arm.linux.org.uk>
 <CAH8gqwVHc9ROQYZNe6b-cUN0ycWhYj8=vJ0geBXUCYN1+XENQA@mail.gmail.com>
Message-ID: <20120103134709.GS2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 09:25:30PM +0800, Richard Zhao wrote:
> Hi Russel,
> 
> On 3 January 2012 17:06, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Dec 26, 2011 at 09:44:52PM +0800, Richard Zhao wrote:
> >> On Mon, Dec 26, 2011 at 11:10:30AM +0000, Mark Brown wrote:
> >> > The *call* is there in the regulator subsystem, it's just that none of
> >> > the drivers back it up with an actual implementation yet. ?Which turns
> >> > out to be a good thing as cpufreq can't currently understand variable
> >> > latencies and the governors don't deal well with non-trivial latencies
> >> > anyway.
> >> but clk API don't have such calls. and many SoCs only adjust clk frequencies, using
> >> one single voltage.
> >
> > That's because it's often not known - especially in the case of PLLs,
> > data sheets don't tend to specify how long it takes for the PLL to relock
> > after a requested change. ?If it's important that the PLL be locked,
> > there will be a bit to poll (or they'll cause the CPU itself to stall
> > while the PLL is not locked.)
> >
> > So, for these kinds of situations, how do you suggest that the clk API
> > provides this information?
> In latest v6 version, I get clk transition latency from dt property, and get
> regulator transition latency from regulator API.
> Could you please help review other arm common changes in v6 version?

You didn't get my point: how do you specify a clock transition latency
for a clock with a PLL when the data sheets don't tell you what that is,
and they instead give you a bit to poll?

Do you:

(a) make up some number and hope that it's representative
(b) not specify any transition latency
(c) think about the problem _now_ and define what it means for a clock
    without a transition latency.
