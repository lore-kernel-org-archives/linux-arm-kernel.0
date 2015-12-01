From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 30 Nov 2015 19:19:47 -0800
Subject: [PATCH v2 00/21] arm64: KVM: world switch in C
In-Reply-To: <20151130203345.GI11704@cbox>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <20151130203345.GI11704@cbox>
Message-ID: <565D11D3.3030502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/30/2015 12:33 PM, Christoffer Dall wrote:
> On Fri, Nov 27, 2015 at 06:49:54PM +0000, Marc Zyngier wrote:
>> Once upon a time, the KVM/arm64 world switch was a nice, clean, lean
>> and mean piece of hand-crafted assembly code. Over time, features have
>> crept in, the code has become harder to maintain, and the smallest
>> change is a pain to introduce. The VHE patches are a prime example of
>> why this doesn't work anymore.
>>
>> This series rewrites most of the existing assembly code in C, but keeps
>> the existing code structure in place (most function names will look
>> familiar to the reader). The biggest change is that we don't have to
>> deal with a static register allocation (the compiler does it for us),
>> we can easily follow structure and pointers, and only the lowest level
>> is still in assembly code. Oh, and a negative diffstat.
>>
>> There is still a healthy dose of inline assembly (system register
>> accessors, runtime code patching), but I've tried not to make it too
>> invasive. The generated code, while not exactly brilliant, doesn't
>> look too shaby. I do expect a small performance degradation, but I
>> believe this is something we can improve over time (my initial
>> measurements don't show any obvious regression though).
> 
> I ran this through my experimental setup on m400 and got this:
> 
> BM		v4.4-rc2	v4.4-rc2-wsinc	overhead
> --		--------	--------------	--------
> Apache		5297.11		5243.77		101.02%
> fio rand read	4354.33		4294.50		101.39%
> fio rand write	2465.33		2231.33		110.49%
> hackbench	17.48		19.78		113.16%
> memcached	96442.69	101274.04	95.23%
> TCP_MAERTS	5966.89		6029.72		98.96%
> TCP_STREAM	6284.60		6351.74		98.94%
> TCP_RR		15044.71	14324.03	105.03%
> pbzip2 c	18.13		17.89		98.68%
> pbzip2 d	11.42		11.45		100.26%
> kernbench	50.13		50.28		100.30%
> mysql 1		152.84		154.01		100.77%
> mysql 2		98.12		98.94		100.84%
> mysql 4		51.32		51.17		99.71%
> mysql 8		27.31		27.70		101.42%
> mysql 20	16.80		17.21		102.47%
> mysql 100	13.71		14.11		102.92%
> mysql 200	15.20		15.20		100.00%
> mysql 400	17.16		17.16		100.00%
> 
> (you want to see this with a viewer that renders clear-text and tabs
> properly)
> 
> What this tells me is that we do take a noticable hit on the
> world-switch path, which shows up in the TCP_RR and hackbench workloads,
> which have a high precision in their output.
> 
> Note that the memcached number is well within its variability between
> individual benchmark runs, where it varies to 12% of its average in over
> 80% of the executions.
> 
> I don't think this is a showstopper thought, but we could consider
> looking more closely at a breakdown of the world-switch path and verify
> if/where we are really taking a hit.
> 
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

I ran some of the lmbench 'micro benchmarks' - currently
the usleep one consistently stands out by about .4% or extra 300ns
per sleep. Few other ones have some outliers, I will look at these
closer. Tests were ran on Juno.

- Mario
