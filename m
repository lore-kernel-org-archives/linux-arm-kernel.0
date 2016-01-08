From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 8 Jan 2016 11:54:30 +0900
Subject: range operation of outer cache when start >= end?
Message-ID: <CAK7LNATi5CE3Uc5UgQ6OncC5b=bDavAyNfqi_nqvcVkOrbFhRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


I know I am nitpicking.  Forgive me if I am asking a silly question.


How should the outer-cache handle such an insane case like  start >= end?

Assumed answers are:

[1] Do not care about that.  It should never happen.  If it does, fix
the caller.

[2]  Add   "if (start < end)" checking to
      outer_inv_range(), outer_clean_range(), outer_flush_range()
      in arch/arm/include/asm/outercache.h

[3] It should be cared in each of callbacks as needed



For example, l2c210_inv_range()
flushes the both ends of the range even if start >= end.

In this case, there is nothing to do, so should it have something like this?
    if (start >= end)
                 return;


static void l2c210_inv_range(unsigned long start, unsigned long end)
{
        void __iomem *base = l2x0_base;

        if (start & (CACHE_LINE_SIZE - 1)) {
                  start &= ~(CACHE_LINE_SIZE - 1);
                  writel_relaxed(start, base + L2X0_CLEAN_INV_LINE_PA);
                  start += CACHE_LINE_SIZE;
        }

        if (end & (CACHE_LINE_SIZE - 1)) {
                  end &= ~(CACHE_LINE_SIZE - 1);
                  writel_relaxed(end, base + L2X0_CLEAN_INV_LINE_PA);
        }

        __l2c210_op_pa_range(base + L2X0_INV_LINE_PA, start, end);
        __l2c210_cache_sync(base);
}





-- 
Best Regards
Masahiro Yamada
