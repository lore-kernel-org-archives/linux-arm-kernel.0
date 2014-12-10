From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 11:57:32 +0100
Subject: [RFC PATCH v2 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <54759991.50204@linaro.org>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <2065254.jRdQcinOdg@wuerfel> <54759991.50204@linaro.org>
Message-ID: <10603826.6Z6KUoI9qZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 17:12:49 Hanjun Guo wrote:
> 
> Thanks for the detail information. I have the concerns about the distance
> for NUMA nodes, does the "ibm,associativity-reference-points" property can
> represent the distance between NUMA nodes?
> 
> For example, a system with 4 sockets connected like below:
> 
> Socket 0  <---->  Socket 1  <---->  Socket 2  <---->  Socket 3
> 
> So from socket 0 to socket 1 (maybe on the same board), it just need 1
> jump to access the memory, but from socket 0 to socket 2/3, it needs
> 2/3 jumps and the *distance* relative longer. Can
> "ibm,associativity-reference-points" property cover this?
> 

Hi Hanjun,

I only today found your replies in my spam folder, I need to put you on
a whitelist so that doesn't happen again.

The above topology is not easy to represent, but I think it would work
like this (ignoring the threads/cores/clusters on the socket, which
would also need to be described in a full DT), using multiple logical
paths between the nodes:

socket 0
ibm,associativity = <0 0 0 0>, <1 1 1 0>, <2 2 0 0>, <3 0 0 0>;

socket 1
ibm,associativity = <1 1 1 1>, <0 0 0 1>, <2 2 2 1>, <3 3 1 1>;

socket 2
ibm,associativity = <2 2 2 2>, <0 0 2 2>, <1 1 1 2>, <3 3 3 2>;

socket 3
ibm,associativity = <3 3 3 3>, <0 3 3 3>, <1 1 3 3>, <2 2 2 3>;

This describes four levels or hierarchy, with the lowest level
being a single CPU core on one socket, and four paths between
the sockets. To compute the associativity between two sockets,
you need to look at each combination of paths to find the best
match.

Comparing sockets 0 and 1, the best matches are <1 1 1 0>
with <1 1 1 1>, and <0 0 0 0> with <0 0 0 1>. In each case, the
associativity is "3", meaning the first three entries match.

Comparing sockets 0 and 3, we have four equally bad matches
that each only match in the highest-level domain, e.g. <0 0 0 0>
with <0 3 3 3>, so the associativity is only "1", and that means
the two nodes are less closely associated than two neighboring
ones.

With the algorithm that powerpc uses to turn associativity into
distance, 2**(numlevels - associativity), this would put the
distance of neighboring nodes at "2", and the longest distance
at "8".

	Arnd
