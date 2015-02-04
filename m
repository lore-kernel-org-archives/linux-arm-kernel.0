From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Feb 2015 17:43:44 +0100
Subject: [rcu] [ INFO: suspicious RCU usage. ]
In-Reply-To: <20150204162814.GG5370@linux.vnet.ibm.com>
References: <1422957702.17540.1.camel@AMDC1943>
 <20150203162704.GR19109@linux.vnet.ibm.com>
 <1423049947.19547.6.camel@AMDC1943>
 <20150204130018.GG8656@n2100.arm.linux.org.uk>
 <20150204131420.GC5370@linux.vnet.ibm.com> <1423059387.24415.2.camel@AMDC1943>
 <20150204151028.GD5370@linux.vnet.ibm.com>
 <1423063348.24415.10.camel@AMDC1943>
 <20150204155615.GF5370@linux.vnet.ibm.com>
 <1423066256.24415.13.camel@AMDC1943>
 <20150204162814.GG5370@linux.vnet.ibm.com>
Message-ID: <1423068224.24415.15.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2015-02-04 at 08:28 -0800, Paul E. McKenney wrote:
> On Wed, Feb 04, 2015 at 05:10:56PM +0100, Krzysztof Kozlowski wrote:
> > On ?ro, 2015-02-04 at 07:56 -0800, Paul E. McKenney wrote:
> > > On Wed, Feb 04, 2015 at 04:22:28PM +0100, Krzysztof Kozlowski wrote:
> > > > 
> > > > Actually the timeout versions but I think that doesn't matter.
> > > > The wait_on_bit will busy-loop with testing for the bit. Inside the loop
> > > > it calls the 'action' which in my case will be bit_wait_io_timeout().
> > > > This calls schedule_timeout().
> > > 
> > > Ah, good point.
> > > 
> > > > See proof of concept in attachment. One observed issue: hot unplug from
> > > > commandline takes a lot more time. About 7 seconds instead of ~0.5.
> > > > Probably I did something wrong.
> > > 
> > > Well, you do set the timeout to five seconds, and so if the condition
> > > does not get set before the surviving CPU finds its way to the
> > > out_of_line_wait_on_bit_timeout(), you are guaranteed to wait for at
> > > least five seconds.
> > >
> > > One alternative approach would be to have a loop around a series of
> > > shorter waits.  Other thoughts?
> > 
> > Right! That was the issue. It seems it works. I'll think also on
> > self-adapting interval as you said below. I'll test it more and send a
> > patch.
> 
> Sounds good!
> 
> Are you doing ARM, ARM64, or both?  I of course vote for both.  ;-)

I'll do both but first I need to find who has ARM64 board in my team.

Best regards,
Krzysztof
