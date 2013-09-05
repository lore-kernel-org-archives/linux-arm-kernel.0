From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Sep 2013 13:45:09 +0100
Subject: [PATCH 3/3] perf: parse the .debug_frame section in case
 .eh_frame is not present
In-Reply-To: <1378317854-25965-4-git-send-email-jean.pihet@linaro.org>
References: <1378317854-25965-1-git-send-email-jean.pihet@linaro.org>
 <1378317854-25965-4-git-send-email-jean.pihet@linaro.org>
Message-ID: <20130905124508.GE9696@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

[adding Michael, since I know he was interested in this]

On Wed, Sep 04, 2013 at 07:04:14PM +0100, Jean Pihet wrote:
> On ARM the debug info is not present in the .eh_frame sections but
> instead in .debug_frame.
> Use libunwind to load and parse the debug info.

How have you tested this? Regardless of whether or not I apply this patch, I
get the same (broken/truncated) callchains for userspace in perf report.

E.g. the following stupid program (built with -O0 -g):

--->8

void bar(void)
{
        int i;
        for (i = 0; i < 1000000; ++i)
                asm volatile("nop" ::: "memory");
}

void foo(void)
{
        bar();
}


int main(void)
{
        foo();
        return 0;
}

8<---

Gives me an incomplete callchain:

# Overhead   Command      Shared Object                           Symbol
# ........  ........  .................  ...............................
#
     0.00%  unwindme  unwindme           [.] bar                        
            |
            --- bar

This is the same with or without your patch.

Will
