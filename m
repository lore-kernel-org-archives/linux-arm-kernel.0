From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 03 Jan 2012 15:25:49 +0100
Subject: [RFC PATCH 0/9] Remove useless on_each_cpu return value
In-Reply-To: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
References: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
Message-ID: <op.v7iidbwz3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Jan 2012 15:19:04 +0100, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> on_each_cpu() returns as its own return value the return value of
> smp_call_function(). smp_call_function() in turn returns a hard
> coded value of zero.
>
> Some callers to on_each_cpu() waste cycles and bloat code space
> by checking the return value to on_each_cpu(), probably for
> historical reasons.
>
> This patch set refactors callers to not test on_each_cpu()
> (fixed) return value and then refactors on_each_cpu to
> return void to avoid confusing future users.
>
> In other words, this patch aims to delete 18 source code lines
> while not changing any functionality :-)
>
> I tested as best as I could the x86 changes and compiled some
> of the others, but I don't have access to all the needed hardware
> for testing. Reviewers and testers welcome!

Other then the lack of Signed-off-by in the patches, looks good to me,
even though personally I'd choose a bottom-up approach, ie. make
smp_call_function() return void and from that conclude that
on_each_cpu() can return void.  With those patches, we have a situation,
where smp_call_function() has a return value which is then lost for no
immediately apparent reason lost in on_each_cpu().

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
