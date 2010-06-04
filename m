From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Fri, 04 Jun 2010 19:25:08 +0530
Subject: facing undefined inconsistent cache issues on cortex-a9
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203BB37005A@dlee02.ent.ti.com>
References: <4BF9F5FB.6020306@st.com>	<EAF47CD23C76F840A9E7FCE10091EFAB02C57001F3@dbde02.ent.ti.com>	<4BFBBD83.5080302@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C57A5FC6@dbde02.ent.ti.com>
	<13B9B4C6EF24D648824FF11BE896716203BB37005A@dlee02.ent.ti.com>
Message-ID: <4C0905BC.1090301@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Woodruff,

On 5/26/2010 12:27 AM, Woodruff, Richard wrote:
> 
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Shilimkar, Santosh
> 
>>>> Does this work if disable L1D as well on the processor you are running
>> Linux ??
>>>>
>>> If we disable the L1 DCache we are never able to boot.
>>> But this might be a different problem.
>>>
>>> If we disable ICache and leave DCache on it is much more stable, and
>>> I think it might be related to timing issue in the data path.
>>>
>> For me, it seems that Cache isn't invalidated properly which leads to this
>> issue.
>> May be you can report the complete crash-log which can give more idea on the
>> issue.
> 
> If you are unable to boot with dcache off then maybe your memory controller or memory part has timing issues.  Cache on will trigger burst accesses using different timings.  Such an early failure is more likely an issue outside of the arm unless you are doing something really odd.

thanks for your inputs. We have some updates in this regard.
In our architecture we have 2 ports coming out of the A9SM (multi core cortex)
block to the interconnect matrix and the transfers are distributed between them.

When we used the address filtering option of SCU to divide and mutually exclude
the traffic between port0 and port1 of A9SM(multi core cortex) block. Like, 
assigning 1 half of the address space to port 1 and rest goes through port0.
This solved the problem with the same set of cache and other system
configurations.
We are not using L2 cache and it is kept disabled. The SCU also is only used for
address filtering and its synchronisation function is disabled (as we are not
bringing up the second core)
Now, we are not able to understand what it means. Do we need to divide the
traffic between ports as described and it is normal. Or there is some problem in
the way the transfers are handled in the system.

regards
Shiraz
