From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 2 Nov 2015 14:33:24 -0500
Subject: [PATCH 1/3] recordmcount: fix endianness handling bug for
 nop_mcount
In-Reply-To: <5634226A.9060208@huawei.com>
References: <1446193864-24593-1-git-send-email-huawei.libin@huawei.com>
 <1446193864-24593-2-git-send-email-huawei.libin@huawei.com>
 <56338025.3060602@cogentembedded.com> <5634226A.9060208@huawei.com>
Message-ID: <20151102143324.071eee7e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 31 Oct 2015 10:07:38 +0800
libin <huawei.libin@huawei.com> wrote:

> 
> 
> on 2015/10/30 22:35, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 10/30/2015 11:31 AM, Li Bin wrote:
> > 
> >> In nop_mcount, shdr->sh_offset and welp->r_offset should handle
> >> endianness properly, otherwise it will trigger Segmentation fault
> >> if the recordmcount main and file.o have different endianness.
> >>
> >> Cc: <stable@vger.kernel.org> # 3.0+
> >> Signed-off-by: Li Bin <huawei.libin@huawei.com>
> >> ---
> >>   scripts/recordmcount.h | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> >> index 49b582a..dda9dba 100644
> >> --- a/scripts/recordmcount.h
> >> +++ b/scripts/recordmcount.h
> >> @@ -376,8 +376,9 @@ static void nop_mcount(Elf_Shdr const *const relhdr,
> >>               mcountsym = get_mcountsym(sym0, relp, str0);
> >>
> >>           if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
> >> -            if (make_nop)
> >> -                ret = make_nop((void *)ehdr, shdr->sh_offset + relp->r_offset);
> >> +            if (make_nop) {
> >> +                ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
> >> +            }
> > 
> >    {} not needed here.
> 
> Oh, yes. When I cleaned the debugging code, forgot delete the {}.
> 
>

Is there a new version of this patch, or should I just take this and
remove the '{}' myself?

I already added the x86 update.

-- Steve
