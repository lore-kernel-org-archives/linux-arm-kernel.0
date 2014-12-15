From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 15 Dec 2014 11:50:00 +0800
Subject: [RFC PATCH v2 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <1833364.xuE8O3LGeh@wuerfel>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <10603826.6Z6KUoI9qZ@wuerfel> <548960F3.7070405@linaro.org>
 <1833364.xuE8O3LGeh@wuerfel>
Message-ID: <548E5A68.2000202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?12?12? 22:20, Arnd Bergmann wrote:
> On Thursday 11 December 2014 17:16:35 Hanjun Guo wrote:
>> On 2014?12?10? 18:57, Arnd Bergmann wrote:
>>> On Wednesday 26 November 2014 17:12:49 Hanjun Guo wrote:
>>> The above topology is not easy to represent, but I think it would work
>>> like this (ignoring the threads/cores/clusters on the socket, which
>>> would also need to be described in a full DT), using multiple logical
>>> paths between the nodes:
>>>
>>> socket 0
>>> ibm,associativity = <0 0 0 0>, <1 1 1 0>, <2 2 0 0>,  0 0 0>;
>>>
>>> socket 1
>>> ibm,associativity = <1 1 1 1>, <0 0 0 1>, <2 2 2 1>,  3 1 1>;
>>>
>>> socket 2
>>> ibm,associativity = <2 2 2 2>, <0 0 2 2>, <1 1 1 2>,  3 3 2>;
>>>
>>> socket 3
>>> ibm,associativity =  3 3 3>, <0 3 3 3>, <1 1 3 3>, <2 2 2 3>;
>>>
>>> This describes four levels or hierarchy, with the lowest level
>>> being a single CPU core on one socket, and four paths between
>>> the sockets. To compute the associativity between two sockets,
>>> you need to look at each combination of paths to find the best
>>> match.
>>>
>>> Comparing sockets 0 and 1, the best matches are <1 1 1 0>
>>> with <1 1 1 1>, and <0 0 0 0> with <0 0 0 1>. In each case, the
>>> associativity is "3", meaning the first three entries match.
>>>
>>> Comparing sockets 0 and 3, we have four equally bad matches
>>> that each only match in the highest-level domain, e.g. <0 0 0 0>
>>> with <0 3 3 3>, so the associativity is only "1", and that means
>>> the two nodes are less closely associated than two neighboring
>>> ones.
>>>
>>> With the algorithm that powerpc uses to turn associativity into
>>> distance, 2**(numlevels - associativity), this would put the
>>> distance of neighboring nodes at "2", and the longest distance
>>> at "8".
>>
>> Thanks for the explain, I can understand how it works now,
>> a bit complicated for me and I think the distance property
>> "node-matrix" in Ganapatrao's patch is straight forward,
>> what do you think?
>
> I still think we should go the whole way of having something compatible
> with the existing bindings, possibly using different property names
> if there are objections to using the "ibm," prefix.

I agree that we should keep using existing bindings and not introducing
a new one.

Thanks
Hanjun
