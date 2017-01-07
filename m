From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2017 09:38:34 +0000
Subject: [PATCHv2 net-next 11/16] net: mvpp2: handle misc PPv2.1/PPv2.2
 differences
In-Reply-To: <1482943592-12556-12-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-12-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170107093834.GJ14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 05:46:27PM +0100, Thomas Petazzoni wrote:
> @@ -6511,7 +6515,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  		dev_err(&pdev->dev, "failed to init port %d\n", id);
>  		goto err_free_stats;
>  	}
> -	mvpp2_port_power_up(port);
> +
> +	if (priv->hw_version == MVPP21)
> +		mvpp21_port_power_up(port);

This has the side effect that nothing clears the port reset bit in the
GMAC, which means there's no hope of the interface working - with the
reset bit set, the port is well and truely held in "link down" state.

In any case, the GMAC part is much the same as mvneta, and I think
that code should be shared rather than writing new versions of it.
There are some subtle differences between neta, pp2.1 and pp2.2, but
it's entirely doable (I have an implementation here as I wasn't going
to duplicate this code for my phylink conversion.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
