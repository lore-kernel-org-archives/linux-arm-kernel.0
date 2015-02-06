From: ddutile@redhat.com (Don Dutile)
Date: Fri, 06 Feb 2015 13:43:26 -0500
Subject: [PATCH] arm64: Change 'Call trace' to 'Call Trace' for tool
 scanners
In-Reply-To: <20150206153459.GE23190@e104818-lin.cambridge.arm.com>
References: <1423157427-41997-1-git-send-email-ddutile@redhat.com>
 <20150206153459.GE23190@e104818-lin.cambridge.arm.com>
Message-ID: <54D50B4E.1050403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2015 10:34 AM, Catalin Marinas wrote:
> On Thu, Feb 05, 2015 at 05:30:27PM +0000, Donald Dutile wrote:
>> Receiving reports from service folks that arm64 uses
>> 'Call trace' when dumping stack, instead of the more familiar
>> 'Call Trace'; the former is not being seen by tools that
>> scan for the latter text.  Checking various arches,
>> it appears the mainstream server arches (ia64, mips, ppc,
>> s390, sparc, x86) use 'Call Trace'.
>> This kernel tools script scans for the latter text string as well
>>    tools/testing/selftests/rcutorture/bin/parse-console.sh
>> so it doesn't appear to be arch or vendor specific.
>>
>> Expecting there aren't a significant number of arm64 dump
>> scanners matching on 'Call trace' so recommend making this change
>> now to minimize changes to dump scanning tools for arm64 servers.
>
> Can you not fix the scripts to check for "Call trace" as well? There are
> 4 more architectures in the kernel using this string (avr32, c6x, metag,
> sh). I also wouldn't count kernel logs as user ABI.
>
I could, but I first received this report from other tools used within RH
that scan for 'Call Trace'.   I pointed to parse-console.sh to show
that RH tools weren't the only ones that were wired with that expectation.

So, adding 'Call trace' to parse-console.sh won't resolve all the other
(primarily server crash) tools that currently match on 'Call Trace'.

I agree with you that I don't consider kernel logs as user ABI, but
as I said, the majority of the heavy, server arches have it that way,
and the tools used on those servers have leaned on this expectation to date.

I didn't modify the other arch's b/c they aren't heavy server arches.

We could carry a patch in our downstream, but then the tools don't resolve
the same way when we do upstream<->downstream comparisons which typically
occur with knarly crash scenarios, which this string would likely show up in.

Cheers, Don
