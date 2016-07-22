From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 22 Jul 2016 18:59:24 +0100
Subject: [PATCH v1 3/4] arm64: Add arm64 kexec support
In-Reply-To: <20160722135630.GC14911@localhost.localdomain>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej> <1469042361.2977.90.camel@infradead.org>
 <20160721103120.GB20559@leverpostej> <5790A902.6070601@arm.com>
 <1469137776.2977.128.camel@infradead.org>
 <20160722040842.GA14911@localhost.localdomain> <5791EF62.5070006@arm.com>
 <20160722135630.GC14911@localhost.localdomain>
Message-ID: <57925EFC.20205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/16 14:56, Pratyush Anand wrote:
> Hi Robin,
> 
> On 22/07/2016:11:03:14 AM, Robin Murphy wrote:
>> On 22/07/16 05:08, Pratyush Anand wrote:
>>> On 21/07/2016:02:49:36 PM, Geoff Levand wrote:
>>>> On Thu, 2016-07-21 at 11:50 +0100, Robin Murphy wrote:
>>>>> The Exynos UART (drivers/tty/serial/samsung.c) is one which comes to
>>>>> mind as definitely existing, and on arm64 systems to boot. The TX
>>>>> register is at offset 0x20 there.
>>>>
>>>> Here's what I came up with.
>>>>
>>>>
>>>> +	struct data {const char *name; int tx_offset;};
>>>> +	static const struct data ok_list[] = {
>>>> +	/*	{"armada-3700-uart", ?},	*/
>>>> +		{"exynos4210-uart", 0x20},
>>>> +	/*	{"ls1021a-lpuart", ?},		*/
>>>> +	/*	{"meson-uart", ?},		*/
>>>> +	/*	{"mt6577-uart", ?},		*/
>>>> +		{"ns16550", 0},
>>>> +		{"ns16550a", 0},
>>>> +		{"pl011", 0},
>>>> +		{NULL, 0}
>>>> +	};
>>>
>>> sinc functionality is just to debug the scenario when something goes wrong in
>>> purgatory. IMHO, it should be disabled by default. So, why not to keep it as
>>> simple as possible. Its a low level debugging mainly for developer, so user
>>> should know the absolute address. Therefore, I think no need to parse earlycon
>>> or earlyprintk from command line.  Whatever user passes in --port can be treated
>>> as address of TX register. If TX offset is 0x20, then user can pass --port as
>>> base+0x20. Additionally, we can pass TX register width as well. So what about
>>> something like "--port=0x1c020000,1" where 0x1c020000 is TX register address and
>>> 1 says about it's width in bytes.
>>
>> I don't think even that is worthwhile, since without any polling it
>> still relies on the UART having FIFOs, someone having already enabled
>> the FIFOs, the FIFOs being deep enough and/or the output being short
>> enough. In short, it's fragile enough that I'm not convinced it's even
>> useful as a debug option. I suggest we simply copy the purgatory console
>> implementation from, say, ARM or Alpha.
> 
> May be I am missing, but deep TX FIFO should not be an issue. Whatever, we write
> in TX register, that will go to the port eventually. However, I do agree that

"Deep" is an issue when in the sense of "not %s enough" ;)

(of which "disabled" is also really just a special case of depth=1)

> short FIFO could be an issue and overflow is quite possible in that case. I had
> been trying to convince Geoff to take [1], which will help to resolve it.

That would make things more useful, yes. As above it would also want
extending to specify the MMIO access size, so for completeness I guess
we'd end up with something like:

--console-tx=<addr>[,{8|16|16be|32|32be}]
--console-status=<addr>,<mask>[,{8|16|16be|32|32be}]

which, other than probably needing some inline asm to guarantee the
appropriate accesses, seems like it could be shared across other
architectures too. Or more bother than it's worth; I can't really decide.

Robin.
