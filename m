From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Jun 2014 18:11:48 +0100
Subject: [PATCH] arm64: ptrace: fix empty registers set in prstatus of
 aarch32 process core
In-Reply-To: <20140603163341.GS23149@arm.com>
References: <1401774369-7060-1-git-send-email-victor.kamensky@linaro.org>
 <1401774369-7060-2-git-send-email-victor.kamensky@linaro.org>
 <20140603144602.GN23149@arm.com>
 <CAA3XUr2J7X3emYJgHFxBcP5TudazU68TQ4DL8YGLDmDSDbDCUw@mail.gmail.com>
 <20140603163341.GS23149@arm.com>
Message-ID: <20140603171148.GE10126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 05:33:41PM +0100, Will Deacon wrote:
> On Tue, Jun 03, 2014 at 05:27:24PM +0100, Victor Kamensky wrote:
> > Hi Will,
> > 
> > On 3 June 2014 07:46, Will Deacon <will.deacon@arm.com> wrote:
> > > Hi Victor,
> > >
> > > Thanks for both the fix and the detailed explanation!
> > >
> > > On Tue, Jun 03, 2014 at 06:46:09AM +0100, Victor Kamensky wrote:
> > >> Currently core file of aarch32 process prstatus note has empty
> > >> registers set. As result aarch32 core files create by V8 kernel are
> > >> not very useful.
> > >>
> > >> It happens because compat_gpr_get and compat_gpr_set functions can
> > >> copy registers values to/from either kbuf or ubuf. ELF core file
> > >> collection function fill_thread_core_info calls compat_gpr_get
> > >> with kbuf set and ubuf set to 0. But current compat_gpr_get and
> > >> compat_gpr_set function handle copy to/from only ubuf case.
> > >>
> > >> Fix is to handle kbuf and ubuf as two separate cases in similar
> > >> way as other functions like user_regset_copyout, user_regset_copyin do.
> > >
> > > An alternative is to use set_fs when kbuf is set, then use
> > > copy_{to,from}_user for everything. However, given how ugly I find
> > > set_fs to start with, your patch looks good to me:
> > >
> > >   Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Thank you for review. Please forgive my naive question, I've tried to
> > google it, but does not look I do a good job. Is there any special thing
> > I need to do, so you or Catalin would pick this up? I've posted patches
> > to Russell's patch system before but never dealt with arm64 patches.
> > 
> > Or I just need to repost the patch to linux-arm-kernel with your
> > 'Acked-by'  and Cc: stable at vger.kernel.org in it?
> 
> Yes, please. Just repost the patch with those tags and we'll pick it up
> after the merge window. If you notice that we've forgotten, please give us a
> prod!

Also don't forget to cc us on the email, it's quicker this way.

Thanks.

-- 
Catalin
