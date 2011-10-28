From: arjan@linux.intel.com (Arjan van de Ven)
Date: Fri, 28 Oct 2011 07:24:07 -0700
Subject: [PATCH v9 2/4] cpuidle: Remove CPUIDLE_FLAG_IGNORE and
	dev->prepare()
In-Reply-To: <20111028105020.7520.68014.stgit@localhost6.localdomain6>
References: <20111028104945.7520.83828.stgit@localhost6.localdomain6>
	<20111028105020.7520.68014.stgit@localhost6.localdomain6>
Message-ID: <4EAABB07.3000305@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
On 10/28/2011 3:50 AM, Deepthi Dharwar wrote:
> The cpuidle_device->prepare() mechanism causes updates to the
> cpuidle_state[].flags, setting and clearing CPUIDLE_FLAG_IGNORE
> to tell the governor not to chose a state on a per-cpu basis at
> run-time. State demotion is now handled by the driver and it returns
> the actual state entered. Hence, this mechanism is not required.
> Also this removes per-cpu flags from cpuidle_state enabling
> it to be made global.
>
 
having worked on some newer platforms....
this one is really still needed. doing this inside the actual states
does not work,
because if the deepest 3 states are invalid, the same (somewhat
expensive) test would have to be done 3 times,
and each of the states would have to fail before the 4th one gets chosen.
that's just not going to work
 
(in the state handler you can't know what other state to fall back to,
and especially not how to enter such a fallback state)
 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
 
iQEcBAEBAgAGBQJOqrsGAAoJEEHdSxh4DVnEu7EH/i5lEJctBAIubJOcZz/tvBFp
XYmAe/HqNtSXeHOVsJkTf8y4ppE8487exF7xxMik4GRN0CZNCtkyMezqDVu+eDim
O/UUbScsAc5cSY6mkjOFXLFup+mi1nkRUnAbxXEyTMhWwcbfr2OvcuO7l7TmATML
hu87P3PVEafEop3q2+uWMc57fFxnNFfEDqRx6N9V+OJKV5dHrRYL4G4E01fYGFLo
xTR0IW7nB15L0C29zk9uk/Dqow8SoJZA83c7p7AieP5zdntb6p7noIf03qmdp19f
fulwMwembCHivo+pLO+jAMhKD1T6VYoCyiYW0LHrQ2E07fayBhFJCxlazgKFcl0=
=FL6o
-----END PGP SIGNATURE-----
