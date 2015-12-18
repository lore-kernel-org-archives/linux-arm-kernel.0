From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Dec 2015 18:03:47 +0000
Subject: [RESEND PATCH v7 2/4] Documentation, dt, arm64/arm: dt bindings
 for numa.
In-Reply-To: <CAFpQJXVmXkgD1FuMbU3rWg5MR3AEeneHAiG6XVfOs6m6e6=byQ@mail.gmail.com>
References: <1450413433-7467-1-git-send-email-gkulkarni@caviumnetworks.com>
 <20151218141826.GB30229@leverpostej>
 <CAFpQJXVmXkgD1FuMbU3rWg5MR3AEeneHAiG6XVfOs6m6e6=byQ@mail.gmail.com>
Message-ID: <20151218180346.GF30229@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 09:00:18PM +0530, Ganapatrao Kulkarni wrote:
> Hi Mark,
> 
> On Fri, Dec 18, 2015 at 7:48 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> +- distance-matrix
> >> +  This property defines a matrix to describe the relative distances
> >> +  between all numa nodes.
> >> +  It is represented as a list of node pairs and their relative distance.
> >> +
> >> +  Note:
> >> +     1. Each entry represents distance from first node to second node.
> >> +     The distance are equal in either direction.
> >> +     2. The distance from a node to self(local distance) is represented
> >> +     with value 10 and all inter node distance should be represented with
> >> +     value greater than 10.
> >> +     3. distance-matrix shold have entries in lexicographical ascending
> >> +     order of nodes.
> >> +     4. There must be only one Device node distance-map and must reside in the root node.
> >
> > I am still concerned that the local distance of 10 is completely
> > arbitrary.
> IMHO, i do not see any issue in having defined local distance to
> arbitrary number(10).
> inter node numa distance is relative number with respect to local distance
> we have to fix local distance to some value, having it in dt to make
> generic will not add
> any additional value as compared to having the fixed local distance to 10.

That's not quite true. The figure chosen for the local distance affects
the granularity with which you can describe all distances.

By using a local distance of 10 we can only encode distances in 10%
chunks of that. Using a local distance of 100 we could encode in 1%
chunks of that.

I believe that for some systems we may need a granularity better than
10%. Certainly for others we may not. Having an explicit property allows
for the description of either, and should be sufficient for a reasonable
period of time to come.

>  #define LOCAL_DISTANCE          10
> this macro which is defined in common code and used in many places in
> common code as well in other arch specific codes.
> If we add property to define local distance and it imply that local
> distance can be changed to any value other than 10.
> having this change demands common code changes wherever LOCAL_DISTANCE is used!.

While certainly painful, occasionally such changes are necessary.

Another option is to scale the input to the kernel's idea of a local
distance (at the possible loss of some granularity).

> I am not finding any reasoning to make local distance generic.

I hope the above has answered some of that.

Thanks,
Mark.
