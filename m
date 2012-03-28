From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 28 Mar 2012 09:19:49 +0900
Subject: [PATCH 2/2] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <20120327074039.GJ5611@n2100.arm.linux.org.uk>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <00d501cd0bb0$724ab260$56e01720$%kim@samsung.com>
 <20120327074039.GJ5611@n2100.arm.linux.org.uk>
Message-ID: <012d01cd0c78$7d2f19a0$778d4ce0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> Sent: Tuesday, March 27, 2012 4:41 PM
> To: Boojin Kim
> Cc: linux-arm-kernel at lists.infradead.org; 'Catalin Marinas'; 'Nicolas Pitre';
> kgene.kim at samsung.com
> Subject: Re: [PATCH 2/2] ARM: lib: use LDRD/STRD for data copy
>
> On Tue, Mar 27, 2012 at 09:27:52AM +0900, Boojin Kim wrote:
> > This patch uses LDRD/STRD that loads and stores data as DWORD unit.
> > It brings better performance than LDRM/STRM with cortex-a15.
>
> Why should I bother looking at this rubbish?  You've been told before
> that using ldrd and strd unconditionally is not acceptable.  Stop
> wasting peoples review time.
This patch brings better memcpy results on Cortex-a15.
Please see following result. I measured it on cortex-a15.
2nd line is default memcpy.
3rd line is memcpy using ldrd/strd with this patch.
4th line is memcpy using ldrd/strd and PLD optimization on my 1st patch.
===================================================================
Memcpy performance (unit: size: Bytes, results: MBps)
===================================================================
size		default	ldrd/strd	ldrd/strd + PLD opti
===================================================================
64		1245.615434	1565.004006		1565.004006
128		1743.861607	2393.535539		2491.230867
256		2199.46509	3212.376645		3487.723214
512		2569.901316	4137.976695		4479.644495
1024		2880.715339	4245.923913		5250.336022
2048		3623.608534	4752.128954		5365.728022
4096		4120.516878	5119.593709		5710.891813
8192		4431.366988	5126.312336		5440.45961
16384		4603.712434	5040.322581		5529.016277
32768		4559.381383	4712.002413		5238.893546
65536		3483.446661	3513.802215		3516.965843
131072		3495.623479	3498.460677		3506.31136
262144		3484.02921	3475.987876		3499.783013
524288		3427.662608	3430.037525		3454.637159
1048576	2263.903195	2225.9222		2458.911587
2097152	1732.182125	1703.940362		1833.96223
4194304	1713.663165	1708.351146		1781.780052
===================================================================
I think it brings meaningful results on cache boundary. So I tried it again.
And, I saw your review. So, I make this patch be effective on cortex-a15 only if machine selects it.
Thanks for your time and review :)
