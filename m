From: james.morse@arm.com (James Morse)
Date: Mon, 07 Dec 2015 13:16:06 +0000
Subject: [PATCH] kexec: Add --lite option
In-Reply-To: <20151207114839.GF16406@dhcppc13.redhat.com>
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <20151022125012.GB20847@redhat.com>
 <1445540891.30908.144.camel@infradead.org>
 <1446703011.12676.83.camel@freescale.com>
 <20151207114547.GE16406@dhcppc13.redhat.com>
 <20151207114839.GF16406@dhcppc13.redhat.com>
Message-ID: <56658696.6070103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 07/12/15 11:48, Pratyush Anand wrote:
>> 1) When we execute kexec() system call in first kernel, at that time it
>> calculates sha256 on all the binaries [1]. It take almost un-noticeable time
>> (less than a sec) there.
>>
>> 2) When purgatory is executed then it re-calculates sha256 using same routines
>> [2] on same binary data as that of case (1). But, now it takes 10-20 sec
>> (depending of size of binaries)?
>>
>> Why did not it take same time with O2 + D-cache enabled? I think, we should be
>> able to achieve same time in second case as well. What is missing?

I haven't benchmarked this, but:

util_lib/sha256.c contains calls out to memcpy().
In your case 1, this will use the glibc version. In case 2, it will use
the version implemented in purgatory/string.c, which is a byte-by-byte copy.


Thanks,

James
