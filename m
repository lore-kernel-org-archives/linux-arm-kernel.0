From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 9 Feb 2016 09:44:20 +0530
Subject: [PATCH 1/2] Documentation: dt: mailbox: Add TI Message Manager
In-Reply-To: <1454690044-2560-2-git-send-email-nm@ti.com>
References: <1454690044-2560-1-git-send-email-nm@ti.com>
 <1454690044-2560-2-git-send-email-nm@ti.com>
Message-ID: <CABb+yY3kGq_R49Xx4fK3UMqtuFiuv-pXJWvjkEFLPL9xRu5T4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2016 at 10:04 PM, Nishanth Menon <nm@ti.com> wrote:
> +
> +       msgmgr: msgmgr at 02a00000 {
> +               compatible = "ti,k2g-message-manager", "ti,message-manager";
> +               #mbox-cells = <1>;
> +               reg-names = "queue_proxy_region", "queue_state_debug_region";
> +               reg = <0x02a00000 0x400000>, <0x028c3400 0x400>;
> +
> +               msgmgr_proxy_pmmc_tx_prio0: pmmc_tx_prio0 {
> +                       ti,queue-id = <0>;
> +                       ti,proxy-id = <0>;
> +               };
> +
> +               msgmgr_proxy_pmmc_rx: pmmc_rx {
> +                       ti,queue-id = <5>;
> +                       ti,proxy-id = <2>;
> +                       interrupt-names = "rx";
> +                       interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
> +               };
> +       };
> +
I think we should get rid of consumer specifics from the provider node...

> +...
> +       pmmc {
> +               ...
> +               mbox-names = "tx", "rx";
> +               mboxes = <&msgmgr &msgmgr_proxy_pmmc_tx>
> +                        <&msgmgr &msgmgr_proxy_pmmc_rx>;
> +               ...
> +       };
>
... and have consumers like
       pmmc {
               ...
               mbox-names = "tx", "rx";
               mboxes = <&msgmgr 0 0>
                        <&msgmgr 5 2>;
       };

I leave the IRQ for you to decide how to specify - a 'dummy' or
'valid' always provided as last cell in mboxes or some other way.
(I'll review other patches in detail later)

cheers.
