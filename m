From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Wed, 18 Oct 2017 09:45:42 +0800
Subject: [bug report & help] arm64: ltp testcase "migrate_pages01" failed
In-Reply-To: <8d412c29-6dd7-126f-1460-23bdd3415816@huawei.com>
References: <59E49B2B.8020802@huawei.com> <59E571ED.9090106@huawei.com>
 <20171017092307.GB21398@arm.com>
 <8d412c29-6dd7-126f-1460-23bdd3415816@huawei.com>
Message-ID: <250b4ab9-e477-4873-0595-a6bbd0762205@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2017/10/17 21:19, Yisheng Xie wrote:
> Hi Will,
> 
> On 2017/10/17 17:23, Will Deacon wrote:
>> On Tue, Oct 17, 2017 at 10:58:53AM +0800, Tan Xiaojun wrote:
>>> I'm not sure if this is the problem on arm64 numa. What do you think ?
>>> By the way, this testcase can be successful in any case on x86.
>>
>> To be honest, this isn't a particularly helpful bug report. I appreciate
>> that a test is reporting failure, but it doesn't look like you've spent
>> very much effort to understand what the test is trying to do and why it
>> thinks it's failed to do it. All I can sensibly do with your bug report
>> is run the test myself, and it passes on the systems I have available.
>>
>> So, you need to:
>>
>> 1. Understand what the test is doing.
>> 2. Figure out which bit isn't doing what it's supposed to
>> 3. See if that part can be isolated to trigger the problem
>>
>> At that point, it should be possible to describe the unexpected behaviour
>> at a level which we can actually investigate if necessary.
> This test case is to test whether we should migrate successfully if user call
> SYSC_migrate_pages with a invalid node. eg, we should 4 node 0-3, and try to
> migrate to node 4. And this should return -EINVAL.
> 
> however, the kernel will migrate the memory to node 0 and return ok(e.g. 0).
> The root cause is for
> 	nodes_subset(*new, node_states[N_MEMORY])
> 
> will return true when new = 0x10 and node_states[N_MEMORY]=0xf, MAX_NUMNODES=4.
> 
> And this is common issue, and I also can reproduce at certain config on X86-64
> e.g. CONFIG_NODES_SHIFT=3 and have 8 node in the system.
> 
> IMO, if nbits=4, 0x0 or 0x10, 0xFF..F0 should not a subset of anything, so following
> patch may fix this problem:

Sorry for having made a mathematics mistake, for empty set should be subset of
any set. Please forget about following patch, and I will send a new one with
node_empty check in SYSC_migrate_pages.

Thanks
Yisheng Xie
> 
> From: Yisheng Xie <xieyisheng1@huawei.com>
> Date: Tue, 17 Oct 2017 20:53:55 +0800
> Subject: [PATCH] bitmap: fix corner case of bitmap_subset
> 
> As Xiaojun reported the ltp of migrate_pages01 will failed in system
> whoes has 4 node with CONFIG_NODES_SHIFT=2:
> 
> migrate_pages01    0  TINFO  :  test_invalid_nodes
> migrate_pages01   14  TFAIL  :  migrate_pages_common.c:45: unexpected failure - returned value = 0, expected: -1
> migrate_pages01   15  TFAIL  :  migrate_pages_common.c:55: call succeeded unexpectedly
> 
> and the root cause is
> 	nodes_subset(*new, node_states[N_MEMORY])
> 
> will return true in the case like: new = 0x10 and node_states[N_MEMORY]=0xf,
> MAX_NUMNODES=4.
> 
> Fix it by correct the corner case of bitmap_subset, which makes 0x0 or
> 0x10, 0xFF..F0  not a subset of bitmap when bitmap lenth is 4.
> 
> Reported-by: Tan Xiaojun <tanxiaojun@huawei.com>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  include/linux/bitmap.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 700cf5f..bc66978 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -283,6 +283,8 @@ static inline int bitmap_intersects(const unsigned long *src1,
>  static inline int bitmap_subset(const unsigned long *src1,
>  			const unsigned long *src2, unsigned int nbits)
>  {
> +	if(!(*src1 & BITMAP_LAST_WORD_MASK(nbits)))
> +		return false;
>  	if (small_const_nbits(nbits))
>  		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
>  	else
> 
