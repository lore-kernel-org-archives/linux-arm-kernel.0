From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Apr 2014 22:59:38 +0800
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5CO8ucya8qmVXBo5kgRmuLqKGtpub07o1DuE9yh5LmmPQ@mail.gmail.com>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
 <20140409133422.GA2334@dragon>
 <CAOMZO5CO8ucya8qmVXBo5kgRmuLqKGtpub07o1DuE9yh5LmmPQ@mail.gmail.com>
Message-ID: <20140409145936.GB2334@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 11:20:28AM -0300, Fabio Estevam wrote:
> On Wed, Apr 9, 2014 at 10:34 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> > I'm not sure this is a full/correct fix to the problem.  You assume that
> > the re-parenting only happens during boot for once?  What about the
> 
> Yes, correct. As far as I can see LDB parent is only set once in clk-imx6q.
> 
> > re-parenting triggered by the clk_set_parent() call?
> 
> Where do you see the LDB clock parent to change via clk_set_parent() call?
> 
> In imx_ldb.c we use clk_set_parent() to set the di parent, not ldb parent.

As long as you call clk_register_mux() to register a multiplexer, you
have to ensure that clk_set_parent() call always works properly on it,
no matter whether there is one actually calling into it right now.

Furthermore, some re-parenting happens in a way you may not be aware of.
See commit e366fdd (clk: clk-mux: implement remuxing on set_rate), for
example.

Shawn
