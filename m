From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jun 2018 17:47:01 +0100
Subject: [PATCH 3/3] rseq/selftests: Add support for arm64
In-Reply-To: <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
 <1529949285-11013-4-git-send-email-will.deacon@arm.com>
 <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com>
 <20180626151427.GF23375@arm.com>
 <1763491947.3520.1530029512923.JavaMail.zimbra@efficios.com>
Message-ID: <20180628164700.GD10751@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Tue, Jun 26, 2018 at 12:11:52PM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 26, 2018, at 11:14 AM, Will Deacon will.deacon at arm.com wrote:
> > On Mon, Jun 25, 2018 at 02:10:10PM -0400, Mathieu Desnoyers wrote:
> >> I notice you are using the instructions
> >> 
> >>   adrp
> >>   add
> >>   str
> >> 
> >> to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
> >> performance-wise with an approach using a literal pool
> >> near the instruction pointer like I did on arm32 ?
> > 
> > I didn't, no. Do you have a benchmark to hand so I can give this a go?
> 
> see tools/testing/selftests/rseq/param_test_benchmark --help
> 
> It's a stripped-down version of param_test, without all the code for
> delay loops and testing checks.
> 
> Example use for counter increment with 4 threads, doing 5G counter
> increments per thread:
> 
> time ./param_test_benchmark -T i -t 4 -r 5000000000

Thanks. I ran that on a few arm64 systems I have access to, with three
configurations of the selftest:

1. As I posted
2. With the abort signature and branch in-lined, so as to avoid the CBNZ
   address limitations in large codebases
3. With both the abort handler and the table inlined (i.e. the same thing
   as 32-bit).

There isn't a reliably measurable difference between (1) and (2), but I take
between 12% and 27% hit between (2) and (3).

So I'll post a v2 based on (2).

Will
