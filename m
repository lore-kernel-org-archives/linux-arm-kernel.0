From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jun 2018 23:08:40 +0200
Subject: [PATCH 2/2] soc: qcom: cmd-db: Fix compiler warnings
In-Reply-To: <20180625205406.GC4689@hector.attlocal.net>
References: <1529946347-12740-1-git-send-email-andy.gross@linaro.org>
 <1529946347-12740-2-git-send-email-andy.gross@linaro.org>
 <CAK8P3a0y9pUC2PQFv-GABnsr7cWWAKuLoDNeC1tC2A8iByzmaw@mail.gmail.com>
 <20180625205406.GC4689@hector.attlocal.net>
Message-ID: <CAK8P3a1+qs3f2cLPKPiMKR4L74dwpAkBcZPNVG4hk_nfx12Xqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 10:54 PM, Andy Gross <andy.gross@linaro.org> wrote:
> On Mon, Jun 25, 2018 at 10:30:17PM +0200, Arnd Bergmann wrote:
>> On Mon, Jun 25, 2018 at 7:05 PM, Andy Gross <andy.gross@linaro.org> wrote:
>>
>> I generally don't like patches that add incorrect initializations to
>> work around warnings like this.
>
> Correct me if I am wrong, but this just masks the warnings on toolchain/
> platforms that exhibit these warnings.  I'm not entirely fond of doing
> blanket init either to make the warnings go away either...

My patch disallows the case where the compiler can see that the variable
is actually used without an initialization, and that code wouldn't
work properly.

The problem is that in this loop:

        for (i = 0; i < MAX_SLV_ID; i++) {
                rsc_hdr = &cmd_db_header->header[i];
                if (!rsc_hdr->slv_id)
                        break;

                ent = rsc_to_entry_header(rsc_hdr);
                for (j = 0; j < le16_to_cpu(rsc_hdr->cnt); j++, ent++) {
                        if (memcmp(ent->id, query, sizeof(ent->id)) == 0)
                                break;
                }

                if (j < le16_to_cpu(rsc_hdr->cnt)) {
                        memcpy(eh, ent, sizeof(*ent));
                        memcpy(rh, rsc_hdr, sizeof(*rh));
                        return 0;
                }
        }

I think gcc sees that cmd_db_header is initialized to NULL and never
written to after of_reserved_mem_lookup() returns NULL during
cmd_db_dev_probe().

This means we are that cmd_db_get_header never intializes the
resulting structure. It also never returns zero, but gcc doesn't
see that here.

A slightly more drastic workaround might be to initialize *eh
at the start of cmd_db_get_header().

     Arnd
