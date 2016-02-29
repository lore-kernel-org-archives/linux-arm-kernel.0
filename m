From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 13:51:51 +0100
Subject: [PATCH] net/mlx5e: make VXLAN support conditional
In-Reply-To: <CALzJLG8MG9y8yr7zi4UTED0FwgBTJ+_5vSSWHB5SHFs-e8WTbg@mail.gmail.com>
References: <1456521217-2174580-1-git-send-email-arnd@arndb.de>
 <CALzJLG8MG9y8yr7zi4UTED0FwgBTJ+_5vSSWHB5SHFs-e8WTbg@mail.gmail.com>
Message-ID: <2455934.lWxXaHB90g@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 February 2016 15:26:53 Saeed Mahameed wrote:
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index 0d45f35aee72..44fc4bc35ffd 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -2116,6 +2116,9 @@ static netdev_features_t mlx5e_vxlan_features_check(struct mlx5e_priv *priv,
> >         u16 proto;
> >         u16 port = 0;
> >
> > +       if (!IS_ENABLED(CONFIG_MLX5_CORE_EN_VXLAN))
> > +               goto out;
> > +
> 
> I would rather wrap the whole mlx5e_features_check with the suggested
> config flag and disable it in case CONFIG_MLX5_CORE_EN_VXLAN is OFF,
> since this function is only needed for when vxlan is supported.

Sounds good.

I think moving the IS_ENABLED() check into the caller(s) will still
result in the same object code, but it makes sense to structure
the code for best readability.

	Arnd
