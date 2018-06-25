From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 25 Jun 2018 15:54:06 -0500
Subject: [PATCH 2/2] soc: qcom: cmd-db: Fix compiler warnings
In-Reply-To: <CAK8P3a0y9pUC2PQFv-GABnsr7cWWAKuLoDNeC1tC2A8iByzmaw@mail.gmail.com>
References: <1529946347-12740-1-git-send-email-andy.gross@linaro.org>
 <1529946347-12740-2-git-send-email-andy.gross@linaro.org>
 <CAK8P3a0y9pUC2PQFv-GABnsr7cWWAKuLoDNeC1tC2A8iByzmaw@mail.gmail.com>
Message-ID: <20180625205406.GC4689@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 10:30:17PM +0200, Arnd Bergmann wrote:
> On Mon, Jun 25, 2018 at 7:05 PM, Andy Gross <andy.gross@linaro.org> wrote:
> > This patch adds initialization of the entry_header structs to avoid
> > compiler warnings like the following:
> >
> >   CC      drivers/soc/qcom/cmd-db.o
> > drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_addr?:
> > drivers/soc/qcom/cmd-db.c:194:21: warning: ?ent.addr? may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >   return ret < 0 ? 0 : le32_to_cpu(ent.addr);
> >
> > drivers/soc/qcom/cmd-db.c: In function ?cmd_db_read_aux_data_len?:
> > drivers/soc/qcom/cmd-db.c:247:38: warning: ?ent.len? may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >   return ret < 0 ? 0 : le16_to_cpu(ent.len);
> 
> Anything wrong with my fix that I posted a while ago?
> See https://lkml.org/lkml/2018/5/25/569

Not entirely, see the comment below.  I missed this one and the other fix
somehow.

> 
> I generally don't like patches that add incorrect initializations to
> work around warnings like this.

Correct me if I am wrong, but this just masks the warnings on toolchain/
platforms that exhibit these warnings.  I'm not entirely fond of doing
blanket init either to make the warnings go away either...


Andy
