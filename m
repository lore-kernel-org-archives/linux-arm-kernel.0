From: lkp@intel.com (kbuild test robot)
Date: Wed, 19 Sep 2018 02:26:29 +0800
Subject: [arm-platforms:kvm-arm64/nv-wip 116/117]
 arch/arm64/kvm/sys_regs.c:1889:31: error: 'trap_raw_wi' undeclared here (not
 in a function); did you mean 'trap_raz_wi'?
Message-ID: <201809190225.gZZBgVvf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-wip
head:   9e2abb310b482718cd7abdd4a506c373750894a5
commit: 9c7b224ca0a4a79d56b72c877aa542e10dfcb353 [116/117] arm64: KVM: NV: Reports GICv3 as being disabled for now
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9c7b224ca0a4a79d56b72c877aa542e10dfcb353
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> arch/arm64/kvm/sys_regs.c:1889:31: error: 'trap_raw_wi' undeclared here (not in a function); did you mean 'trap_raz_wi'?
     { SYS_DESC(SYS_ICC_SRE_EL2), trap_raw_wi },
                                  ^~~~~~~~~~~
                                  trap_raz_wi

vim +1889 arch/arm64/kvm/sys_regs.c

  1564	
  1565	/*
  1566	 * Architected system registers.
  1567	 * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
  1568	 *
  1569	 * Debug handling: We do trap most, if not all debug related system
  1570	 * registers. The implementation is good enough to ensure that a guest
  1571	 * can use these with minimal performance degradation. The drawback is
  1572	 * that we don't implement any of the external debug, none of the
  1573	 * OSlock protocol. This should be revisited if we ever encounter a
  1574	 * more demanding guest...
  1575	 */
  1576	static const struct sys_reg_desc sys_reg_descs[] = {
  1577		{ SYS_DESC(SYS_DC_ISW), access_dcsw },
  1578		{ SYS_DESC(SYS_DC_CSW), access_dcsw },
  1579		{ SYS_DESC(SYS_DC_CISW), access_dcsw },
  1580	
  1581		DBG_BCR_BVR_WCR_WVR_EL1(0),
  1582		DBG_BCR_BVR_WCR_WVR_EL1(1),
  1583		{ SYS_DESC(SYS_MDCCINT_EL1), trap_debug_regs, reset_val, MDCCINT_EL1, 0 },
  1584		{ SYS_DESC(SYS_MDSCR_EL1), trap_debug_regs, reset_val, MDSCR_EL1, 0 },
  1585		DBG_BCR_BVR_WCR_WVR_EL1(2),
  1586		DBG_BCR_BVR_WCR_WVR_EL1(3),
  1587		DBG_BCR_BVR_WCR_WVR_EL1(4),
  1588		DBG_BCR_BVR_WCR_WVR_EL1(5),
  1589		DBG_BCR_BVR_WCR_WVR_EL1(6),
  1590		DBG_BCR_BVR_WCR_WVR_EL1(7),
  1591		DBG_BCR_BVR_WCR_WVR_EL1(8),
  1592		DBG_BCR_BVR_WCR_WVR_EL1(9),
  1593		DBG_BCR_BVR_WCR_WVR_EL1(10),
  1594		DBG_BCR_BVR_WCR_WVR_EL1(11),
  1595		DBG_BCR_BVR_WCR_WVR_EL1(12),
  1596		DBG_BCR_BVR_WCR_WVR_EL1(13),
  1597		DBG_BCR_BVR_WCR_WVR_EL1(14),
  1598		DBG_BCR_BVR_WCR_WVR_EL1(15),
  1599	
  1600		{ SYS_DESC(SYS_MDRAR_EL1), trap_raz_wi },
  1601		{ SYS_DESC(SYS_OSLAR_EL1), trap_raz_wi },
  1602		{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1 },
  1603		{ SYS_DESC(SYS_OSDLR_EL1), trap_raz_wi },
  1604		{ SYS_DESC(SYS_DBGPRCR_EL1), trap_raz_wi },
  1605		{ SYS_DESC(SYS_DBGCLAIMSET_EL1), trap_raz_wi },
  1606		{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
  1607		{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
  1608	
  1609		{ SYS_DESC(SYS_MDCCSR_EL0), trap_raz_wi },
  1610		{ SYS_DESC(SYS_DBGDTR_EL0), trap_raz_wi },
  1611		// DBGDTR[TR]X_EL0 share the same encoding
  1612		{ SYS_DESC(SYS_DBGDTRTX_EL0), trap_raz_wi },
  1613	
  1614		{ SYS_DESC(SYS_DBGVCR32_EL2), NULL, reset_val, DBGVCR32_EL2, 0 },
  1615	
  1616		{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
  1617	
  1618		/*
  1619		 * ID regs: all ID_SANITISED() entries here must have corresponding
  1620		 * entries in arm64_ftr_regs[].
  1621		 */
  1622	
  1623		/* AArch64 mappings of the AArch32 ID registers */
  1624		/* CRm=1 */
  1625		ID_SANITISED(ID_PFR0_EL1),
  1626		ID_SANITISED(ID_PFR1_EL1),
  1627		ID_SANITISED(ID_DFR0_EL1),
  1628		ID_HIDDEN(ID_AFR0_EL1),
  1629		{ SYS_DESC(SYS_ID_MMFR0_EL1), access_id_aa64mmfr0_el1, NULL, 0, 0,
  1630		  get_id_reg, set_id_reg },
  1631		ID_SANITISED(ID_MMFR1_EL1),
  1632		ID_SANITISED(ID_MMFR2_EL1),
  1633		ID_SANITISED(ID_MMFR3_EL1),
  1634	
  1635		/* CRm=2 */
  1636		ID_SANITISED(ID_ISAR0_EL1),
  1637		ID_SANITISED(ID_ISAR1_EL1),
  1638		ID_SANITISED(ID_ISAR2_EL1),
  1639		ID_SANITISED(ID_ISAR3_EL1),
  1640		ID_SANITISED(ID_ISAR4_EL1),
  1641		ID_SANITISED(ID_ISAR5_EL1),
  1642		ID_SANITISED(ID_MMFR4_EL1),
  1643		ID_UNALLOCATED(2,7),
  1644	
  1645		/* CRm=3 */
  1646		ID_SANITISED(MVFR0_EL1),
  1647		ID_SANITISED(MVFR1_EL1),
  1648		ID_SANITISED(MVFR2_EL1),
  1649		ID_UNALLOCATED(3,3),
  1650		ID_UNALLOCATED(3,4),
  1651		ID_UNALLOCATED(3,5),
  1652		ID_UNALLOCATED(3,6),
  1653		ID_UNALLOCATED(3,7),
  1654	
  1655		/* AArch64 ID registers */
  1656		/* CRm=4 */
  1657		ID_SANITISED(ID_AA64PFR0_EL1),
  1658		ID_SANITISED(ID_AA64PFR1_EL1),
  1659		ID_UNALLOCATED(4,2),
  1660		ID_UNALLOCATED(4,3),
  1661		ID_UNALLOCATED(4,4),
  1662		ID_UNALLOCATED(4,5),
  1663		ID_UNALLOCATED(4,6),
  1664		ID_UNALLOCATED(4,7),
  1665	
  1666		/* CRm=5 */
  1667		ID_SANITISED(ID_AA64DFR0_EL1),
  1668		ID_SANITISED(ID_AA64DFR1_EL1),
  1669		ID_UNALLOCATED(5,2),
  1670		ID_UNALLOCATED(5,3),
  1671		ID_HIDDEN(ID_AA64AFR0_EL1),
  1672		ID_HIDDEN(ID_AA64AFR1_EL1),
  1673		ID_UNALLOCATED(5,6),
  1674		ID_UNALLOCATED(5,7),
  1675	
  1676		/* CRm=6 */
  1677		ID_SANITISED(ID_AA64ISAR0_EL1),
  1678		ID_SANITISED(ID_AA64ISAR1_EL1),
  1679		ID_UNALLOCATED(6,2),
  1680		ID_UNALLOCATED(6,3),
  1681		ID_UNALLOCATED(6,4),
  1682		ID_UNALLOCATED(6,5),
  1683		ID_UNALLOCATED(6,6),
  1684		ID_UNALLOCATED(6,7),
  1685	
  1686		/* CRm=7 */
  1687		ID_SANITISED(ID_AA64MMFR0_EL1),
  1688		ID_SANITISED(ID_AA64MMFR1_EL1),
  1689		ID_SANITISED(ID_AA64MMFR2_EL1),
  1690		ID_UNALLOCATED(7,3),
  1691		ID_UNALLOCATED(7,4),
  1692		ID_UNALLOCATED(7,5),
  1693		ID_UNALLOCATED(7,6),
  1694		ID_UNALLOCATED(7,7),
  1695	
  1696		{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
  1697		{ SYS_DESC(SYS_CPACR_EL1), access_rw, reset_val, CPACR_EL1, 0 },
  1698		{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
  1699		{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
  1700		{ SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
  1701	
  1702		{ SYS_DESC(SYS_SPSR_EL1), access_spsr, reset_unknown, SPSR_EL1},
  1703		{ SYS_DESC(SYS_ELR_EL1), access_elr, reset_unknown, ELR_EL1},
  1704	
  1705		{ SYS_DESC(SYS_AFSR0_EL1), access_vm_reg, reset_unknown, AFSR0_EL1 },
  1706		{ SYS_DESC(SYS_AFSR1_EL1), access_vm_reg, reset_unknown, AFSR1_EL1 },
  1707		{ SYS_DESC(SYS_ESR_EL1), access_vm_reg, reset_unknown, ESR_EL1 },
  1708	
  1709		{ SYS_DESC(SYS_ERRIDR_EL1), trap_raz_wi },
  1710		{ SYS_DESC(SYS_ERRSELR_EL1), trap_raz_wi },
  1711		{ SYS_DESC(SYS_ERXFR_EL1), trap_raz_wi },
  1712		{ SYS_DESC(SYS_ERXCTLR_EL1), trap_raz_wi },
  1713		{ SYS_DESC(SYS_ERXSTATUS_EL1), trap_raz_wi },
  1714		{ SYS_DESC(SYS_ERXADDR_EL1), trap_raz_wi },
  1715		{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
  1716		{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
  1717	
  1718		{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
  1719		{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
  1720	
  1721		{ SYS_DESC(SYS_PMINTENSET_EL1), access_pminten, reset_unknown, PMINTENSET_EL1 },
  1722		{ SYS_DESC(SYS_PMINTENCLR_EL1), access_pminten, NULL, PMINTENSET_EL1 },
  1723	
  1724		{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
  1725		{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
  1726	
  1727		{ SYS_DESC(SYS_LORSA_EL1), trap_undef },
  1728		{ SYS_DESC(SYS_LOREA_EL1), trap_undef },
  1729		{ SYS_DESC(SYS_LORN_EL1), trap_undef },
  1730		{ SYS_DESC(SYS_LORC_EL1), trap_undef },
  1731		{ SYS_DESC(SYS_LORID_EL1), trap_undef },
  1732	
  1733		{ SYS_DESC(SYS_VBAR_EL1), access_rw, reset_val, VBAR_EL1, 0 },
  1734		{ SYS_DESC(SYS_DISR_EL1), NULL, reset_val, DISR_EL1, 0 },
  1735	
  1736		{ SYS_DESC(SYS_ICC_IAR0_EL1), write_to_read_only },
  1737		{ SYS_DESC(SYS_ICC_EOIR0_EL1), read_from_write_only },
  1738		{ SYS_DESC(SYS_ICC_HPPIR0_EL1), write_to_read_only },
  1739		{ SYS_DESC(SYS_ICC_DIR_EL1), read_from_write_only },
  1740		{ SYS_DESC(SYS_ICC_RPR_EL1), write_to_read_only },
  1741		{ SYS_DESC(SYS_ICC_SGI1R_EL1), access_gic_sgi },
  1742		{ SYS_DESC(SYS_ICC_ASGI1R_EL1), access_gic_sgi },
  1743		{ SYS_DESC(SYS_ICC_SGI0R_EL1), access_gic_sgi },
  1744		{ SYS_DESC(SYS_ICC_IAR1_EL1), write_to_read_only },
  1745		{ SYS_DESC(SYS_ICC_EOIR1_EL1), read_from_write_only },
  1746		{ SYS_DESC(SYS_ICC_HPPIR1_EL1), write_to_read_only },
  1747		{ SYS_DESC(SYS_ICC_SRE_EL1), access_gic_sre },
  1748	
  1749		{ SYS_DESC(SYS_CONTEXTIDR_EL1), access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
  1750		{ SYS_DESC(SYS_TPIDR_EL1), NULL, reset_unknown, TPIDR_EL1 },
  1751	
  1752		{ SYS_DESC(SYS_CNTKCTL_EL1), NULL, reset_val, CNTKCTL_EL1, 0},
  1753	
  1754		{ SYS_DESC(SYS_CSSELR_EL1), NULL, reset_unknown, CSSELR_EL1 },
  1755	
  1756		{ SYS_DESC(SYS_PMCR_EL0), access_pmcr, reset_pmcr, },
  1757		{ SYS_DESC(SYS_PMCNTENSET_EL0), access_pmcnten, reset_unknown, PMCNTENSET_EL0 },
  1758		{ SYS_DESC(SYS_PMCNTENCLR_EL0), access_pmcnten, NULL, PMCNTENSET_EL0 },
  1759		{ SYS_DESC(SYS_PMOVSCLR_EL0), access_pmovs, NULL, PMOVSSET_EL0 },
  1760		{ SYS_DESC(SYS_PMSWINC_EL0), access_pmswinc, reset_unknown, PMSWINC_EL0 },
  1761		{ SYS_DESC(SYS_PMSELR_EL0), access_pmselr, reset_unknown, PMSELR_EL0 },
  1762		{ SYS_DESC(SYS_PMCEID0_EL0), access_pmceid },
  1763		{ SYS_DESC(SYS_PMCEID1_EL0), access_pmceid },
  1764		{ SYS_DESC(SYS_PMCCNTR_EL0), access_pmu_evcntr, reset_unknown, PMCCNTR_EL0 },
  1765		{ SYS_DESC(SYS_PMXEVTYPER_EL0), access_pmu_evtyper },
  1766		{ SYS_DESC(SYS_PMXEVCNTR_EL0), access_pmu_evcntr },
  1767		/*
  1768		 * PMUSERENR_EL0 resets as unknown in 64bit mode while it resets as zero
  1769		 * in 32bit mode. Here we choose to reset it as zero for consistency.
  1770		 */
  1771		{ SYS_DESC(SYS_PMUSERENR_EL0), access_pmuserenr, reset_val, PMUSERENR_EL0, 0 },
  1772		{ SYS_DESC(SYS_PMOVSSET_EL0), access_pmovs, reset_unknown, PMOVSSET_EL0 },
  1773	
  1774		{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
  1775		{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
  1776	
  1777		{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_arch_timer },
  1778		{ SYS_DESC(SYS_CNTP_CTL_EL0), access_arch_timer },
  1779		{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_arch_timer },
  1780	
  1781		/* PMEVCNTRn_EL0 */
  1782		PMU_PMEVCNTR_EL0(0),
  1783		PMU_PMEVCNTR_EL0(1),
  1784		PMU_PMEVCNTR_EL0(2),
  1785		PMU_PMEVCNTR_EL0(3),
  1786		PMU_PMEVCNTR_EL0(4),
  1787		PMU_PMEVCNTR_EL0(5),
  1788		PMU_PMEVCNTR_EL0(6),
  1789		PMU_PMEVCNTR_EL0(7),
  1790		PMU_PMEVCNTR_EL0(8),
  1791		PMU_PMEVCNTR_EL0(9),
  1792		PMU_PMEVCNTR_EL0(10),
  1793		PMU_PMEVCNTR_EL0(11),
  1794		PMU_PMEVCNTR_EL0(12),
  1795		PMU_PMEVCNTR_EL0(13),
  1796		PMU_PMEVCNTR_EL0(14),
  1797		PMU_PMEVCNTR_EL0(15),
  1798		PMU_PMEVCNTR_EL0(16),
  1799		PMU_PMEVCNTR_EL0(17),
  1800		PMU_PMEVCNTR_EL0(18),
  1801		PMU_PMEVCNTR_EL0(19),
  1802		PMU_PMEVCNTR_EL0(20),
  1803		PMU_PMEVCNTR_EL0(21),
  1804		PMU_PMEVCNTR_EL0(22),
  1805		PMU_PMEVCNTR_EL0(23),
  1806		PMU_PMEVCNTR_EL0(24),
  1807		PMU_PMEVCNTR_EL0(25),
  1808		PMU_PMEVCNTR_EL0(26),
  1809		PMU_PMEVCNTR_EL0(27),
  1810		PMU_PMEVCNTR_EL0(28),
  1811		PMU_PMEVCNTR_EL0(29),
  1812		PMU_PMEVCNTR_EL0(30),
  1813		/* PMEVTYPERn_EL0 */
  1814		PMU_PMEVTYPER_EL0(0),
  1815		PMU_PMEVTYPER_EL0(1),
  1816		PMU_PMEVTYPER_EL0(2),
  1817		PMU_PMEVTYPER_EL0(3),
  1818		PMU_PMEVTYPER_EL0(4),
  1819		PMU_PMEVTYPER_EL0(5),
  1820		PMU_PMEVTYPER_EL0(6),
  1821		PMU_PMEVTYPER_EL0(7),
  1822		PMU_PMEVTYPER_EL0(8),
  1823		PMU_PMEVTYPER_EL0(9),
  1824		PMU_PMEVTYPER_EL0(10),
  1825		PMU_PMEVTYPER_EL0(11),
  1826		PMU_PMEVTYPER_EL0(12),
  1827		PMU_PMEVTYPER_EL0(13),
  1828		PMU_PMEVTYPER_EL0(14),
  1829		PMU_PMEVTYPER_EL0(15),
  1830		PMU_PMEVTYPER_EL0(16),
  1831		PMU_PMEVTYPER_EL0(17),
  1832		PMU_PMEVTYPER_EL0(18),
  1833		PMU_PMEVTYPER_EL0(19),
  1834		PMU_PMEVTYPER_EL0(20),
  1835		PMU_PMEVTYPER_EL0(21),
  1836		PMU_PMEVTYPER_EL0(22),
  1837		PMU_PMEVTYPER_EL0(23),
  1838		PMU_PMEVTYPER_EL0(24),
  1839		PMU_PMEVTYPER_EL0(25),
  1840		PMU_PMEVTYPER_EL0(26),
  1841		PMU_PMEVTYPER_EL0(27),
  1842		PMU_PMEVTYPER_EL0(28),
  1843		PMU_PMEVTYPER_EL0(29),
  1844		PMU_PMEVTYPER_EL0(30),
  1845		/*
  1846		 * PMCCFILTR_EL0 resets as unknown in 64bit mode while it resets as zero
  1847		 * in 32bit mode. Here we choose to reset it as zero for consistency.
  1848		 */
  1849		{ SYS_DESC(SYS_PMCCFILTR_EL0), access_pmu_evtyper, reset_val, PMCCFILTR_EL0, 0 },
  1850	
  1851		{ SYS_DESC(SYS_VPIDR_EL2), access_rw, reset_val, VPIDR_EL2, 0 },
  1852		{ SYS_DESC(SYS_VMPIDR_EL2), access_rw, reset_val, VMPIDR_EL2, 0 },
  1853	
  1854		{ SYS_DESC(SYS_SCTLR_EL2), access_rw, reset_val, SCTLR_EL2, 0 },
  1855		{ SYS_DESC(SYS_ACTLR_EL2), access_rw, reset_val, ACTLR_EL2, 0 },
  1856		{ SYS_DESC(SYS_HCR_EL2), access_rw, reset_val, HCR_EL2, 0 },
  1857		{ SYS_DESC(SYS_MDCR_EL2), access_rw, reset_val, MDCR_EL2, 0 },
  1858		{ SYS_DESC(SYS_CPTR_EL2), access_rw, reset_val, CPTR_EL2, 0 },
  1859		{ SYS_DESC(SYS_HSTR_EL2), access_rw, reset_val, HSTR_EL2, 0 },
  1860		{ SYS_DESC(SYS_HACR_EL2), access_rw, reset_val, HACR_EL2, 0 },
  1861	
  1862		{ SYS_DESC(SYS_TTBR0_EL2), access_rw, reset_val, TTBR0_EL2, 0 },
  1863		{ SYS_DESC(SYS_TTBR1_EL2), access_rw, reset_val, TTBR1_EL2, 0 },
  1864		{ SYS_DESC(SYS_TCR_EL2), access_rw, reset_val, TCR_EL2, 0 },
  1865		{ SYS_DESC(SYS_VTTBR_EL2), access_vttbr_el2, reset_val, VTTBR_EL2, 0 },
  1866		{ SYS_DESC(SYS_VTCR_EL2), access_rw, reset_val, VTCR_EL2, 0 },
  1867	
  1868		{ SYS_DESC(SYS_DACR32_EL2), NULL, reset_unknown, DACR32_EL2 },
  1869		{ SYS_DESC(SYS_SPSR_EL2), access_spsr_el2, reset_val, SPSR_EL2, 0 },
  1870		{ SYS_DESC(SYS_ELR_EL2), access_rw, reset_val, ELR_EL2, 0 },
  1871		{ SYS_DESC(SYS_SP_EL1), access_sp_el1, reset_unknown, SP_EL1 },
  1872	
  1873		{ SYS_DESC(SYS_IFSR32_EL2), NULL, reset_unknown, IFSR32_EL2 },
  1874		{ SYS_DESC(SYS_AFSR0_EL2), access_rw, reset_val, AFSR0_EL2, 0 },
  1875		{ SYS_DESC(SYS_AFSR1_EL2), access_rw, reset_val, AFSR1_EL2, 0 },
  1876		{ SYS_DESC(SYS_ESR_EL2), access_rw, reset_val, ESR_EL2, 0 },
  1877		{ SYS_DESC(SYS_FPEXC32_EL2), NULL, reset_val, FPEXC32_EL2, 0x70 },
  1878	
  1879		{ SYS_DESC(SYS_FAR_EL2), access_rw, reset_val, FAR_EL2, 0 },
  1880		{ SYS_DESC(SYS_HPFAR_EL2), access_rw, reset_val, HPFAR_EL2, 0 },
  1881	
  1882		{ SYS_DESC(SYS_MAIR_EL2), access_rw, reset_val, MAIR_EL2, 0 },
  1883		{ SYS_DESC(SYS_AMAIR_EL2), access_rw, reset_val, AMAIR_EL2, 0 },
  1884	
  1885		{ SYS_DESC(SYS_VBAR_EL2), access_rw, reset_val, VBAR_EL2, 0 },
  1886		{ SYS_DESC(SYS_RVBAR_EL2), access_rw, reset_val, RVBAR_EL2, 0 },
  1887		{ SYS_DESC(SYS_RMR_EL2), access_rw, reset_val, RMR_EL2, 0 },
  1888	
> 1889		{ SYS_DESC(SYS_ICC_SRE_EL2), trap_raw_wi },
  1890	
  1891		{ SYS_DESC(SYS_CONTEXTIDR_EL2), access_rw, reset_val, CONTEXTIDR_EL2, 0 },
  1892		{ SYS_DESC(SYS_TPIDR_EL2), access_rw, reset_val, TPIDR_EL2, 0 },
  1893	
  1894		{ SYS_DESC(SYS_CNTVOFF_EL2), access_rw, reset_val, CNTVOFF_EL2, 0 },
  1895		{ SYS_DESC(SYS_CNTHCTL_EL2), access_rw, reset_val, CNTHCTL_EL2, 0 },
  1896	
  1897		{ SYS_DESC(SYS_CNTHP_TVAL_EL2), access_arch_timer },
  1898		{ SYS_DESC(SYS_CNTHP_CTL_EL2), access_arch_timer },
  1899		{ SYS_DESC(SYS_CNTHP_CVAL_EL2), access_arch_timer },
  1900		{ SYS_DESC(SYS_CNTHV_TVAL_EL2), access_arch_timer },
  1901		{ SYS_DESC(SYS_CNTHV_CTL_EL2), access_arch_timer },
  1902		{ SYS_DESC(SYS_CNTHV_CVAL_EL2), access_arch_timer },
  1903	
  1904		{ SYS_DESC(sctlr_EL12), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
  1905		{ SYS_DESC(cpacr_EL12), access_rw, reset_val, CPACR_EL1, 0 },
  1906		{ SYS_DESC(ttbr0_EL12), access_vm_reg, reset_unknown, TTBR0_EL1 },
  1907		{ SYS_DESC(ttbr1_EL12), access_vm_reg, reset_unknown, TTBR1_EL1 },
  1908		{ SYS_DESC(tcr_EL12), access_vm_reg, reset_val, TCR_EL1, 0 },
  1909		{ SYS_DESC(spsr_EL12), access_spsr},
  1910		{ SYS_DESC(elr_EL12), access_elr},
  1911		{ SYS_DESC(afsr0_EL12), access_vm_reg, reset_unknown, AFSR0_EL1 },
  1912		{ SYS_DESC(afsr1_EL12), access_vm_reg, reset_unknown, AFSR1_EL1 },
  1913		{ SYS_DESC(esr_EL12), access_vm_reg, reset_unknown, ESR_EL1 },
  1914		{ SYS_DESC(far_EL12), access_vm_reg, reset_unknown, FAR_EL1 },
  1915		{ SYS_DESC(mair_EL12), access_vm_reg, reset_unknown, MAIR_EL1 },
  1916		{ SYS_DESC(amair_EL12), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
  1917		{ SYS_DESC(vbar_EL12), access_rw, reset_val, VBAR_EL1, 0 },
  1918		{ SYS_DESC(contextidr_EL12), access_vm_reg, reset_val, CONTEXTIDR_EL1, 0 },
  1919		{ SYS_DESC(cntkctl_EL12), access_rw, reset_val, CNTKCTL_EL1, 0 },
  1920	
  1921		{ SYS_DESC(cntp_tval_EL02), access_arch_timer },
  1922		{ SYS_DESC(cntp_ctl_EL02), access_arch_timer },
  1923		{ SYS_DESC(cntp_cval_EL02), access_arch_timer },
  1924	
  1925		{ SYS_DESC(cntv_tval_EL02), access_arch_timer },
  1926		{ SYS_DESC(cntv_ctl_EL02), access_arch_timer },
  1927		{ SYS_DESC(cntv_cval_EL02), access_arch_timer },
  1928	
  1929		{ SYS_DESC(SYS_SP_EL2), NULL, reset_unknown, SP_EL2 },
  1930	};
  1931	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40210 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180919/6db0de7b/attachment-0001.gz>
