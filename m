From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 17 May 2013 09:57:07 +0100
Subject: ux500 breaking multi-platform kernels
In-Reply-To: <CAL_JsqJzf8Aj6+K_qEYo3JbAoeJn36EerBfaGYT9EQj-zPaHUw@mail.gmail.com>
References: <CAL_JsqJzf8Aj6+K_qEYo3JbAoeJn36EerBfaGYT9EQj-zPaHUw@mail.gmail.com>
Message-ID: <5195F0E3.6020402@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/13 21:30, Rob Herring wrote:
> @@ -39,10 +39,10 @@ static int __init ux500_l2x0_init(void)
>  {
>         u32 aux_val = 0x3e000000;
> 
> -       if (cpu_is_u8500_family() || cpu_is_ux540_family())
> -               l2x0_base = __io_address(U8500_L2CC_BASE);
> -       else
> -               ux500_unknown_soc();
> +       if (!(cpu_is_u8500_family() || cpu_is_ux540_family()))
> +               return -ENODEV;
> +
> +       l2x0_base = __io_address(U8500_L2CC_BASE);

I think moving
early_initcall(ux500_l2x0_init);

to
MACHINE
.init_early = ux500_l2x0_init

should solve this issue neatly.


--srini
